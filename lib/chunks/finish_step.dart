import 'package:ai_sdk_client/chunks/base.dart';

import 'package:ai_sdk_client/chunks/type.dart';

class FinishStepChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final Map<String, dynamic> data;

  FinishStepChunk({super.type = ChunkType.finishStep, required this.data}) : super(data: data);
}
