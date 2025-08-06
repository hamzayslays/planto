import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static double averageRatings(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void feildFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,
      ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    if (!context.mounted) return;
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(12),
        positionOffset: 20,
        icon: const Icon(Icons.error),
        flushbarPosition: FlushbarPosition.TOP,
        message: message,
      )..show(context),
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context) {
    if (!context.mounted) return;
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.green,
        reverseAnimationCurve: Curves.easeInOut,
        duration: Duration(seconds: 3),
        borderRadius: BorderRadius.circular(12),
        positionOffset: 20,
        icon: const Icon(Icons.check_circle),
        flushbarPosition: FlushbarPosition.TOP,
        message: message,
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    if (!context.mounted) return;
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text(message)),
    );
  }

  static Future<void> saveUserIdToLocalStorage(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  static Future<String> getUserIdFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId") ?? "";
  }

}
