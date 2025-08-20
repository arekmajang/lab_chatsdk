import 'page_route.dart';

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final PageRoute? pageRoute;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.pageRoute,
  });
}