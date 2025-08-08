import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextInputType keyboardType;
  final Function(String) onSaved;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.onSaved,
    this.hint,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      keyboardType: keyboardType,
      onSaved: (value) => onSaved(value!),
      validator: (value) => value!.isEmpty ? "Required" : null,
    );
  }
}
