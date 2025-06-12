import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class StartStepChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  StartStepChunk({super.type = ChunkType.startStep, required this.data}) : super(data: data);
}
