class ChatConfig {
  final String baseUrl;
  final String sdkKey;
  final String? completionEndpoint;

  const ChatConfig({
    required this.baseUrl,
    required this.sdkKey,
    this.completionEndpoint = '/anvaya/completion',
  });

  String get fullUrl => '$baseUrl$completionEndpoint';
}