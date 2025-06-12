import 'dart:async';
import 'dart:convert';

import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/data.dart';
import 'package:ai_sdk_client/chunks/error.dart';
import 'package:ai_sdk_client/chunks/file.dart';
import 'package:ai_sdk_client/chunks/finish_message.dart';
import 'package:ai_sdk_client/chunks/finish_step.dart';
import 'package:ai_sdk_client/chunks/message_annotation.dart';
import 'package:ai_sdk_client/chunks/reasoning.dart';
import 'package:ai_sdk_client/chunks/reasoning_signature.dart';
import 'package:ai_sdk_client/chunks/redacted_reasoning.dart';
import 'package:ai_sdk_client/chunks/source.dart';
import 'package:ai_sdk_client/chunks/start_step.dart';
import 'package:ai_sdk_client/chunks/text.dart';
import 'package:ai_sdk_client/chunks/tool_call.dart';
import 'package:ai_sdk_client/chunks/tool_call_delta.dart';
import 'package:ai_sdk_client/chunks/tool_call_streaming_start.dart';
import 'package:ai_sdk_client/chunks/tool_result.dart';
import 'package:ai_sdk_client/chunks/unknown.dart';
import 'package:ai_sdk_client/extensions/string.dart';

class AiSDKConsumeValue {
  final StreamController<BaseChunk> controller;
  final Iterable<BaseChunk> chunks;

  AiSDKConsumeValue({required this.controller, required this.chunks});
}

class AiSDKStreamConsumer {
  final Stream<List<int>> stream;
  final String endChunkPrefix;

  /// A class that consumes a stream of chunks and returns a stream of chunks.
  AiSDKStreamConsumer({required this.stream, this.endChunkPrefix = 'd:'});

  /// Consumes the stream of chunks and returns a stream of chunks.
  Future<AiSDKConsumeValue> consume() async {
    final chunks = <BaseChunk>[];
    final controller = StreamController<BaseChunk>();

    () async {
      stream.listen(
        (event) {
          if (controller.isClosed) return;
          try {
            final decodedChunk = String.fromCharCodes(event);
            final decodedChunks = decodedChunk.split('\n').where((line) => line.trim().isNotEmpty).toList(); // stream smoothing sends multiple chunks at once
            for (final chunk in decodedChunks) {
              if (controller.isClosed) break;

              if (chunk.startsWith("0:")) {
                final data = chunk.substring(2);
                final textChunk = TextChunk(data: _cleanChunk(data));
                controller.add(textChunk);
                chunks.add(textChunk);
              } else if (chunk.startsWith("g:")) {
                final data = chunk.substring(2);
                final reasoningChunk = ReasoningChunk(data: _cleanChunk(data));
                controller.add(reasoningChunk);
                chunks.add(reasoningChunk);
              } else if (chunk.startsWith("i:")) {
                final data = chunk.substring(2);
                final redactedReasoningChunk = RedactedReasoningChunk(data: jsonDecode(data));
                controller.add(redactedReasoningChunk);
                chunks.add(redactedReasoningChunk);
              } else if (chunk.startsWith("j:")) {
                final data = chunk.substring(2);
                final reasoningSignatureChunk = ReasoningSignatureChunk(data: jsonDecode(data));
                controller.add(reasoningSignatureChunk);
                chunks.add(reasoningSignatureChunk);
              } else if (chunk.startsWith("h:")) {
                final data = chunk.substring(2);
                final sourceChunk = SourceChunk(data: jsonDecode(data));
                controller.add(sourceChunk);
                chunks.add(sourceChunk);
              } else if (chunk.startsWith("k:")) {
                final data = chunk.substring(2);
                final fileChunk = FileChunk(data: jsonDecode(data));
                controller.add(fileChunk);
                chunks.add(fileChunk);
              } else if (chunk.startsWith("2:")) {
                final data = chunk.substring(2);
                final dataChunk = DataChunk(data: jsonDecode(data));
                controller.add(dataChunk);
                chunks.add(dataChunk);
              } else if (chunk.startsWith("8:")) {
                final data = chunk.substring(2);
                final messageAnnotationChunk = MessageAnnotation(data: jsonDecode(data));
                controller.add(messageAnnotationChunk);
                chunks.add(messageAnnotationChunk);
              } else if (chunk.startsWith("3:")) {
                final data = chunk.substring(2);
                final errorChunk = ErrorChunk(data: _cleanChunk(data));
                controller.add(errorChunk);
                chunks.add(errorChunk);
              } else if (chunk.startsWith("b:")) {
                final data = chunk.substring(2);
                final toolCallStreamingStartChunk = ToolCallStreamingStartChunk(data: jsonDecode(data));
                controller.add(toolCallStreamingStartChunk);
                chunks.add(toolCallStreamingStartChunk);
              } else if (chunk.startsWith("c:")) {
                final data = chunk.substring(2);
                final toolCallDeltaChunk = ToolCallDeltaChunk(data: jsonDecode(data));
                controller.add(toolCallDeltaChunk);
                chunks.add(toolCallDeltaChunk);
              } else if (chunk.startsWith("9:")) {
                final data = chunk.substring(2);
                final toolCallChunk = ToolCallChunk(data: jsonDecode(data));
                controller.add(toolCallChunk);
                chunks.add(toolCallChunk);
              } else if (chunk.startsWith("a:")) {
                final data = chunk.substring(2);
                final toolResultChunk = ToolResultChunk(data: jsonDecode(data));
                controller.add(toolResultChunk);
                chunks.add(toolResultChunk);
              } else if (chunk.startsWith("f:")) {
                final data = chunk.substring(2);
                final startStepChunk = StartStepChunk(data: jsonDecode(data));
                controller.add(startStepChunk);
                chunks.add(startStepChunk);
              } else if (chunk.startsWith("e:")) {
                final data = chunk.substring(2);
                final finishStepChunk = FinishStepChunk(data: jsonDecode(data));
                controller.add(finishStepChunk);
                chunks.add(finishStepChunk);
              } else if (chunk.startsWith("d:")) {
                final data = chunk.substring(2);
                final finishMessageChunk = FinishMessageChunk(data: jsonDecode(data));
                controller.add(finishMessageChunk);
                chunks.add(finishMessageChunk);
              } else {
                final unknownChunk = UnknownChunk(data: chunk);
                controller.add(unknownChunk);
                chunks.add(unknownChunk);
              }
              if (chunk.startsWith(endChunkPrefix)) {
                controller.close();
                break;
              }
            }
          } catch (e) {}
        },
        onError: (error, stackTrace) {
          print(error);
          print(stackTrace);
        },
        onDone: () {
          print('done');
        },
      );
    }();

    return AiSDKConsumeValue(controller: controller, chunks: chunks);
  }

  String _cleanChunk(String chunk) {
    return chunk.replaceFirst('"', "").replaceLast('"', '').replaceAll('\\"', '"').replaceAll('\\\\', '\\').replaceAll('\\n', '\n');
  }
}
