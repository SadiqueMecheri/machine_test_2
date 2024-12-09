// auth_repository.dart
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'Model/login_response.dart';
import 'error_handler.dart';
import 'session/shared_preferences.dart';

class AuthRepository {
  final basicurl = "https://frijo.noviindus.in/api/";

  Future<LoginResponse> login(String username, String password) async {
    var url = "${basicurl}otp_verified";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'country_code': username, 'phone': password},
      );

      log("Response Status Code: ${response.statusCode}");

      if (response.statusCode == 202) {
        log("Response Body: ${response.body}");
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else if (response.statusCode >= 500) {
        throw Exception("Server error: ${response.reasonPhrase}");
      } else {
        return LoginResponse(
          status: false,
          message: "Invalid response from server. Please try again.",
          token: null,
          phone: '',
          privilage: false,
        );
      }
    } catch (e) {
      log("Error: ${e.toString()}");
      throw Exception(ErrorHandler.handleError(e));
    }
  }
}
