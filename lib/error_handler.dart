// error_handler.dart
class ErrorHandler {
  static String handleError(Object error) {
    if (error is NetworkException) {
      return "No Internet connection. Please check your network.";
    } else if (error.toString().contains("Server error")) {
      return "Server is currently unavailable. Please try again later.";
    } else {
      return "An unexpected error occurred. Please try again.";
    }
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException([this.message = "No network connection."]);

  @override
  String toString() => message;
}
