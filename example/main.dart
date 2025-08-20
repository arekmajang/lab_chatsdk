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
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleChatWidget(
      config: const ChatConfig(
        baseUrl: 'http://localhost:8080',
        sdkKey: 'your-sdk-key-here',
      ),
      title: 'Example Chat',
      onPageRoute: (page, params) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DemoPage(page: page, params: params),
          ),
        );
      },
    );
  }
}

class DemoPage extends StatelessWidget {
  final String page;
  final Map<String, dynamic>? params;

  const DemoPage({super.key, required this.page, this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$page Page')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Page: $page'),
            if (params != null)
              Text('Params: $params'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Chat'),
            ),
          ],
        ),
      ),
    );
  }
}