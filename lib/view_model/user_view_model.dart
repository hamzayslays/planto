import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    // Save token
    await sp.setString('Token', user.token ?? '');

    if (user.users != null) {
      final Users u = user.users!;
      await sp.setString('id', u.id ?? '');
      await sp.setString('name', u.name ?? '');
      await sp.setString('email', u.email ?? '');
    }

    notifyListeners();
    return true;
  }

  // Future<bool> saveUser(UserModel user) async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setString('token', user.token.toString());
  //   return true;
  // }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    // Retrieve fields
    final String? token = sp.getString('Token');
    final String? id = sp.getString('id');
    final String? name = sp.getString('name');
    final String? email = sp.getString('email');

    // Reconstruct user and user model
    Users user = Users(id: id, name: name, email: email);

    return UserModel(token: token, users: token != null ? user : null);
  }

  // Future<UserModel> getUser() async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   final String? token = sp.getString('token');
  //
  //   return UserModel(token: token.toString());
  // }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('Token');
    return true;
  }
}
