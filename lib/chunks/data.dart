import 'package:ai_sdk_client/chunks/base.dart';
import 'package:ai_sdk_client/chunks/type.dart';

class DataChunk extends BaseChunk {
  @override
  // ignore: overridden_fields
  final List<Map<String, dynamic>> data;

  DataChunk({super.type = ChunkType.data, required this.data}) : super(data: data);
}
