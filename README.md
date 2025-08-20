# SimpleChat SDK

A Flutter SDK for integrating chat functionality with configurable API endpoints.

## Features

- Configurable base URL and SDK key
- Simple chat widget ready to use
- HTTP-based chat completion API integration
- Customizable UI

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  simplechat_sdk:
    path: ../path/to/simplechat_sdk
```

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:simplechat_sdk/simplechat_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpleChatWidget(
        config: ChatConfig(
          baseUrl: 'http://localhost:8080',
          sdkKey: 'your-sdk-key-here',
        ),
        title: 'My Chat App',
      ),
    );
  }
}
```

### Configuration

```dart
ChatConfig(
  baseUrl: 'https://your-api.com',
  sdkKey: 'your-secret-key',
  completionEndpoint: '/custom/completion', // Optional, defaults to '/anvaya/completion'
)
```

### Custom Integration

```dart
// Use ChatService directly for custom implementations
final chatService = ChatService(config);
final response = await chatService.sendMessage('Hello!');
```

## API Requirements

Your API should:
- Accept POST requests with JSON body: `{"text": "user message"}`
- Return JSON response: `{"text": "bot response"}`
- Support Authorization header with Bearer token
