import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class FinishMessageChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  FinishMessageChunk({super.type = ChunkType.finishMessage, required this.data}) : super(data: data);
}
