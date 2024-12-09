import 'dart:developer';

class LoginResponse {
  final bool status;
  final String message;
  final Token? token;
  final String phone;
  final bool privilage;

  LoginResponse({
    required this.status,
    required this.message,
    this.token,
    required this.phone,
    required this.privilage,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    log("lodeddd");
    return LoginResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] != null ? Token.fromJson(json['token']) : null,
      phone: json['phone'] ?? '',
      privilage: json['privilage'] ?? false,
    );
  }
}

class Token {
  final String accessToken;
  final String refreshToken;

  Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access'] ?? '', // Default to empty string if absent
      refreshToken: json['refresh'] ?? '',
    );
  }
}

// Example usage
final response = LoginResponse(
  status: false,
  message: "Invalid response from server.",
  token: null,
  phone: '',
  privilage: false,
);
