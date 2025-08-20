import 'package:flutter/material.dart';
import 'simplechat_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleChat SDK Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SimpleChatWidget(
        config: const ChatConfig(
          baseUrl: 'http://localhost:8080',
          sdkKey: 'your-sdk-key-here',
        ),
        title: 'SDK Example Chat',
      ),
    );
  }
}
