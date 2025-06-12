import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class ReasoningSignatureChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  ReasoningSignatureChunk({super.type = ChunkType.reasoningSignature, required this.data}) : super(data: data);
}
