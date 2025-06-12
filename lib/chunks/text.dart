import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class TextChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final String data;

  TextChunk({super.type = ChunkType.text, required this.data}) : super(data: data);
}
