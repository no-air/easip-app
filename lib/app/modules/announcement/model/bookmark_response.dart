class BookmarkResponse {
  final bool success;

  BookmarkResponse({required this.success});

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) {
    return BookmarkResponse(
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
    };
  }
}