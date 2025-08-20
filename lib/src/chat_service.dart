import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_config.dart';

class ChatService {
  final ChatConfig config;

  ChatService(this.config);

  Future<String> sendMessage(String text) async {
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
        return data['text'] ?? 'No response';
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}