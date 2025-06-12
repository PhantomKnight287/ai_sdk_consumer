<div align="center">
  <h1>ai_sdk_client</h1>
  <p>A Dart library for consuming vercel AI SDK data streams</p>
</div>

> [!NOTE]
> This only supports vercel v4 AI SDK stream protocol compatible streams.

## Installation

```bash
dart pub add ai_sdk_client
```

## Setup
This package is pure dart and does not require any native dependencies.

## Usage

```dart
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
```

## Chunks

This package supports all the chunks that are supported by the vercel AI SDK.

You can find the chunks in the `lib/chunks` directory.

## License

MIT