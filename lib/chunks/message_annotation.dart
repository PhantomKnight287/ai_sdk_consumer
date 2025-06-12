import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class MessageAnnotation extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  MessageAnnotation({super.type = ChunkType.messageAnnotation, required this.data}) : super(data: data);
}
