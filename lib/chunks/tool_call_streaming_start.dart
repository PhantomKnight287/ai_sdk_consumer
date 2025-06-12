import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class ToolCallStreamingStartChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  ToolCallStreamingStartChunk({super.type = ChunkType.toolCallStreamingStart, required this.data}) : super(data: data);
}
