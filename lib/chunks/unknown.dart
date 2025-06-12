import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class UnknownChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Object data;

  UnknownChunk({super.type = ChunkType.unknown, required this.data}) : super(data: data);
}
