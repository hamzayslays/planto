import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomField extends StatelessWidget {
  final String? labText;
  final TextEditingController? controller;
  final String? Function(String?)? valid;
  final Widget? suffix;
  final Widget? prefix;
  final String? hint;
  final bool isObscure;

  const CustomField({
    super.key,
    this.labText,
    this.controller,
    this.valid,
    this.suffix,
    this.hint,
    this.prefix,
    this.isObscure = false

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      controller: controller,
      validator: valid,
      decoration: InputDecoration(
        labelText: labText,
        labelStyle: TextStyle(
          color:  Color(0xFF706F6F),
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(),
        suffixIcon: suffix,
        prefixIcon: prefix,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:  BorderSide(color: Colors.green.shade500),
        ),
      ),
    );
  }
}
