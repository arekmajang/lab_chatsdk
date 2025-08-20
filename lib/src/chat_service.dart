import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_config.dart';
import 'models/page_route.dart';

class ChatResponse {
  final String text;
  final PageRoute? pageRoute;

  ChatResponse({required this.text, this.pageRoute});
}

class ChatService {
  final ChatConfig config;

  ChatService(this.config);

  Future<ChatResponse> sendMessage(String text) async {
    try {
      final response = await http.post(
        Uri.parse(config.fullUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${config.sdkKey}',
        },
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ChatResponse(
          text: data['text'] ?? 'No response',
          pageRoute: data['pageRoute'] != null 
              ? PageRoute.fromJson(data['pageRoute']) 
              : null,
        );
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}