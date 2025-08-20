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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat SDK Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SimpleChatWidget(
                config: const ChatConfig(
                  baseUrl: 'http://localhost:8080',
                  sdkKey: 'your-sdk-key-here',
                ),
                title: 'SDK Example Chat',
                onPageRoute: (page, params) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageRouteScreen(
                        page: page,
                        params: params,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          child: const Text('Open Chat'),
        ),
      ),
    );
  }
}

class PageRouteScreen extends StatelessWidget {
  final String page;
  final Map<String, dynamic>? params;

  const PageRouteScreen({super.key, required this.page, this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$page Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Page: $page', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            if (params != null) ...
              params!.entries.map(
                (e) => Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 16)),
              ),
            const SizedBox(height: 32),
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
