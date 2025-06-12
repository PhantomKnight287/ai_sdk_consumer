import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class ErrorChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final String data;

  ErrorChunk({super.type = ChunkType.error, required this.data}) : super(data: data);
}
