import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class ToolCallDeltaChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  ToolCallDeltaChunk({super.type = ChunkType.toolCallDelta, required this.data}) : super(data: data);
}
