import 'package:ai_sdk_client/chunks/base.dart';

import 'package:ai_sdk_client/chunks/type.dart';

class ToolCallChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  ToolCallChunk({super.type = ChunkType.toolCall, required this.data}) : super(data: data);
}
