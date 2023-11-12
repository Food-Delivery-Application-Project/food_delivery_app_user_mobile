class ApiResponse<T> {
  final String message;
  final int status;
  final T data;

  ApiResponse({
    required this.message,
    required this.status,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      message: json['message'] as String,
      status: json['status'] as int,
      data: fromJsonT(json['data']),
    );
  }
}
