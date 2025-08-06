import 'package:flutter/material.dart';

import '../repositories/auth_repo.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';

class SignUpViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signUpUser(dynamic data, BuildContext context) async {
    setLoading(true);

    try {
      final response = await _authRepo.signUpApi(data);
      setLoading(false);

      // success logic
      Utils.toastMessage("Signup Success");
      Navigator.pushNamed(context, RoutesName.home);

    } catch (e) {
      setLoading(false);
      Utils.toastMessage(e.toString());
    }
  }
}
