import 'package:flutter/material.dart';
import 'package:planto/utils/routes/routes_name.dart';
import '../repositories/auth_repo.dart';
import '../utils/utils.dart';

class OtpViewModel extends ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> verifyOtp({
    required BuildContext context,
    required String email,
    required String otp,
  }) async {
    setLoading(true);

    try {
      final response = await _authRepo.verifyOtpWithForgotPassword(email, otp);
      setLoading(false);

      if (response != null && response['status'] == 200) {
        Utils.flushBarSuccessMessage(
          response['msg'] ?? "OTP Verified",
          context,
        );

        Navigator.pushNamed(context, RoutesName.changePassword,
        arguments: email
        );
      } else {
        Utils.flushBarErrorMessage(
          response['msg'] ?? "Invalid OTP, please try again.",
          context,
        );
      }
    } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage("Something went wrong. Try again.", context);
    }
  }
}
