import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:planto/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../repositories/auth_repo.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool isloading = false;
  bool _loading = false;

  bool get loading => _loading;

  bool _signUpLoading = false;

  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _myRepo.loginApi(data);
      setLoading(false);

      if (value['warning'] != null) {
        // Show error message and stop here (don't navigate)
        if (context.mounted) {
          Utils.flushBarErrorMessage(value['warning'], context);
        }
        return;
      }

      // Only proceed if there's no warning
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      UserModel userModel = UserModel.fromJson(value);
      await userPreference.saveUser(userModel);

      if (context.mounted) {
        Utils.flushBarSuccessMessage('Login Successfully', context);
        Navigator.pushReplacementNamed(context, RoutesName.bottom);
      }

      if (kDebugMode) print(value.toString());
    } catch (error) {
      setLoading(false);

      if (context.mounted) {
        String errorMessage = 'Login failed';

        if (error is DioException && error.response?.data != null) {
          final responseData = error.response!.data;
          if (responseData is Map && responseData.containsKey('msg')) {
            errorMessage = responseData['msg'];
          }
        }

        Utils.flushBarErrorMessage(errorMessage, context);
      }

      if (kDebugMode) print("Login Error: $error");
    }
  }

  Future<void> signUpApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    try {
      final value = await _myRepo.signUpApi(data);
      setSignUpLoading(false);

      if (context.mounted) {
        Utils.flushBarSuccessMessage('Sign up Successfully', context);

        Navigator.pushNamed(context, RoutesName.login);
      }

      if (kDebugMode) print(value.toString());
    } catch (error) {
      setSignUpLoading(false);

      if (context.mounted) {
        Utils.flushBarErrorMessage(error.toString(), context);
      }

      if (kDebugMode) print("SignUp Error: $error");
    }
  }

  Future<void> sentOtp(BuildContext context, String email) async {
    try {
      isloading = true;
      notifyListeners();

      // Prepare request body
      Map<String, dynamic> data = {
        "email": email,
      };

      // API call
      final response = await _myRepo.sendOtpApi(data);

      isloading = false;
      notifyListeners();

      if(response['status'] == 200) {
        // Navigate to OTP screen and pass email as argument
        Navigator.pushNamed(context, RoutesName.otpScreen, arguments: email);

        Utils.flushBarSuccessMessage(
            response['message'] ?? 'OTP sent', context);
      } else {
        Utils.flushBarErrorMessage(
            response['message'] ?? 'Failed to send OTP', context);
      }
    } catch (e) {
      isloading = false;
      notifyListeners();

      Utils.flushBarErrorMessage('Something went wrong', context);
      if (kDebugMode) {
        print('Send OTP Error: $e');
      }
    }
  }
}
