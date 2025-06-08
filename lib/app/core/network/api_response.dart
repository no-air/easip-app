class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;
  final String? error;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, {T? data}) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'],
      data: data,
      error: json['error'],
    );
  }
}