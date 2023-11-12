class ApiResponse<T> {
  final String apiVersion;
  final String organizationName;
  final String message;
  final int responseCode;
  final T data;

  ApiResponse({
    required this.apiVersion,
    required this.organizationName,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponse(
      apiVersion: json['apiVersion'] as String,
      organizationName: json['organizationName'] as String,
      message: json['message'] as String,
      responseCode: json['responseCode'] as int,
      data: fromJsonT(json['data']),
    );
  }
}
