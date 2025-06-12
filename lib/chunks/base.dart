import 'package:ai_sdk_client/chunks/type.dart';

class BaseChunk {
  final ChunkType type;
  final Object data;

  BaseChunk({required this.type, required this.data});

  @override
  String toString() {
    return 'BaseChunk(type: $type, data: $data)';
  }
}
