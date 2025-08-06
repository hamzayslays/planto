import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_fields.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthViewModel>(
      create: (_) => AuthViewModel(),
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.h),
                      Center(
                        child: Text(
                          'Forgot password',
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Please enter your email address. You will receive an OTP code',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(height: 16.h),
                      CustomField(
                        controller: _emailController,
                        hint: 'Enter your email',
                        labText: 'Email',
                        suffix: Icon(Icons.email),
                        valid: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      authViewModel.isloading
                          ? Center(child: CircularProgressIndicator())
                          : CustomButtons(
                        name: 'Send',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authViewModel.sentOtp(context, _emailController.text.trim());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
