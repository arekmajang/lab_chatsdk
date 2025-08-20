import 'package:flutter/material.dart';
import 'package:simplechat_sdk/simplechat_sdk.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleChat SDK Example',
      home: SimpleChatWidget(
        config: const ChatConfig(
          baseUrl: 'http://localhost:8080',
          sdkKey: 'your-sdk-key-here',
        ),
        title: 'Example Chat',
      ),
    );
  }
}