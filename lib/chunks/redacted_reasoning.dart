import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class RedactedReasoningChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final String data;

  RedactedReasoningChunk({super.type = ChunkType.redactedReasoning, required this.data}) : super(data: data);
}
