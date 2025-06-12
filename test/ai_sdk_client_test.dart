import 'package:ai_sdk_client/ai_sdk_client.dart';
import 'package:dio/dio.dart';
import 'dart:async';

void main() async {
  final dio = Dio();
  final req = await dio.post(
    'http://localhost:8080',
    options: Options(
      responseType: ResponseType.stream,
    ),
  );
  final stream = req.data.stream as Stream<List<int>>;
  final streamConsumer = AiSDKStreamConsumer(stream: stream);
  final chunks = await streamConsumer.consume();

  // Create a subscription to handle the stream
  final subscription = chunks.controller.stream.listen(
    (event) {
      print('Received chunk: $event');
    },
    onError: (error) {
      print('Error in stream: $error');
    },
    onDone: () {
      print('Stream completed');
    },
  );

  // Keep the connection open for 30 seconds as an example
  print('Connection will stay open for 30 seconds...');
  await Future.delayed(Duration(seconds: 60));

  // Clean up when done
  subscription.cancel();
  chunks.controller.close();
  print('Connection closed');
}
