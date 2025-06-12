import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class ToolResultChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  ToolResultChunk({super.type = ChunkType.toolResult, required this.data}) : super(data: data);
}
