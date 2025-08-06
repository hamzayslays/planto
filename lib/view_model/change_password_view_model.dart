import 'package:flutter/material.dart';
import '../repositories/auth_repo.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    setLoading(true);

    try {
      final response = await _authRepo.resetPasswordApi({
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      });

      setLoading(false);
      return response;
    } catch (e) {
      setLoading(false);
      return {
        "status": 500,
        "msg": "Something went wrong",
      };
    }
  }
}
