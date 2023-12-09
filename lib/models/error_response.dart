// class ErrorResponse {
//   final int statusCode;
//   final String message;
//   final String? error; // Optional field for error type
//   final Map<String, dynamic>? details; // Optional field for additional details

//   ErrorResponse({
//     required this.statusCode,
//     required this.message,
//     this.error,
//     this.details,
//   });

//   factory ErrorResponse.fromJson(Map<String, dynamic> json) {
//     return ErrorResponse(
//       statusCode: json['status_code'] ?? 500,
//       message: json['message'] ?? 'Unknown error occurred',
//       error: json['error'],
//       details: json['details'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status_code': statusCode,
//       'message': message,
//       'error': error,
//       'details': details,
//     };
//   }
// }
