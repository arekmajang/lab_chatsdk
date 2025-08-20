class PageRoute {
  final String page;
  final Map<String, dynamic>? param;

  PageRoute({
    required this.page,
    this.param,
  });

  factory PageRoute.fromJson(Map<String, dynamic> json) {
    return PageRoute(
      page: json['page'],
      param: json['param'],
    );
  }
}