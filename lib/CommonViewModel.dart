import 'package:flutter/material.dart';
import 'Model/login_response.dart';
import 'auth_repository.dart';
import 'error_handler.dart';

class CommonViewModel extends ChangeNotifier {
  final AuthRepository _repository;
  bool _isLoading = false;
  String _message = "";
  LoginResponse? _loginResponse;

  CommonViewModel(this._repository);

  bool get isLoading => _isLoading;
  String get message => _message;
  LoginResponse? get loginResponse => _loginResponse;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _message = "";
    notifyListeners();

    try {
      final response = await _repository.login(username, password);
      if (response.status) {
        _loginResponse = response;
      } else {
        _message = response.message;
      }
    } catch (e) {
      _message = ErrorHandler.handleError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
