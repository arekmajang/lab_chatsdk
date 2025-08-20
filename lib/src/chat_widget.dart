import 'package:flutter/material.dart';
import 'chat_service.dart';
import 'chat_config.dart';
import 'models/message.dart';
import 'models/page_route.dart';

typedef PageRouteCallback = void Function(String page, Map<String, dynamic>? params);

class SimpleChatWidget extends StatefulWidget {
  final ChatConfig config;
  final String? title;
  final PageRouteCallback? onPageRoute;

  const SimpleChatWidget({
    super.key,
    required this.config,
    this.title = 'Chat',
    this.onPageRoute,
  });

  @override
  State<SimpleChatWidget> createState() => _SimpleChatWidgetState();
}

class _SimpleChatWidgetState extends State<SimpleChatWidget> {
  late final ChatService _chatService;
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _chatService = ChatService(widget.config);
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        Message(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _isLoading = true;
    });

    _controller.clear();

    try {
      final response = await _chatService.sendMessage(text);
      setState(() {
        _messages.add(
          Message(
            text: response.text,
            isUser: false,
            timestamp: DateTime.now(),
            pageRoute: response.pageRoute,
          ),
        );
      });
    } catch (e) {
      setState(() {
        _messages.add(
          Message(text: e.toString(), isUser: false, timestamp: DateTime.now()),
        );
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Chat'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment:
                      message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          message.isUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(message.text),
                        if (message.pageRoute != null && !message.isUser)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                if (widget.onPageRoute != null) {
                                  widget.onPageRoute!(
                                    message.pageRoute!.page,
                                    message.pageRoute!.param,
                                  );
                                }
                              },
                              child: Text('Go to ${message.pageRoute!.page}'),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _sendMessage(_controller.text),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
