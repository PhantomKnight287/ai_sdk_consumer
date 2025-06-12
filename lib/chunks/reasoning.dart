import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class ReasoningChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final String data;

  ReasoningChunk({super.type = ChunkType.reasoning, required this.data}) : super(data: data);
}
