class NetworkResponse {
  final int? statusCode;
  final bool isSuccess;
  final String? errorMessage;
  final dynamic jsonResponse;

  NetworkResponse({
    this.statusCode = -1,
    required this.isSuccess,
    this.errorMessage = 'Something went wrong',
    this.jsonResponse,
  });
}
