// otp_box.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;

  const OtpBox({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 55,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters, // ABC not abc
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 2),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')), // A-Z, 0–9
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            controller.text = value.toUpperCase(); // Just in case
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          }
        },
      ),
    );
  }
}
