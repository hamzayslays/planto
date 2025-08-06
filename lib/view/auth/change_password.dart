import 'package:flutter/material.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_fields.dart';
import '../../view_model/change_password_view_model.dart';

class ChangePassword extends StatefulWidget {
  final String email;
  const ChangePassword({super.key, required this.email});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> _obscureConfirm = ValueNotifier(true);

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _obscurePassword.dispose();
    _obscureConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child: Consumer<ChangePasswordViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(title: const Text("Reset Password")),
            body: Padding(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // New Password Field
                    ValueListenableBuilder(
                      valueListenable: _obscurePassword,
                      builder: (_, value, __) {
                        return CustomField(
                          labText: "New Password",
                          controller: _passwordController,
                          isObscure: value,
                          hint: "Enter new password",
                          suffix: IconButton(
                            icon: Icon(value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => _obscurePassword.value = !value,
                          ),
                          valid: (val) =>
                          val!.isEmpty ? "Password is required" : null,
                        );
                      },
                    ),

                    SizedBox(height: 15.h),

                    // Confirm Password Field
                    ValueListenableBuilder(
                      valueListenable: _obscureConfirm,
                      builder: (_, value, __) {
                        return CustomField(
                          labText: "Confirm Password",
                          controller: _confirmPasswordController,
                          isObscure: value,
                          hint: "Re-enter new password",
                          suffix: IconButton(
                            icon: Icon(value
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => _obscureConfirm.value = !value,
                          ),
                          valid: (val) {
                            if (val!.isEmpty) return "Please confirm password";
                            if (val != _passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    SizedBox(height: 25.h),

                    CustomButtons(
                      name: 'Reset',
                      onPressed: viewModel.isLoading
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await viewModel.resetPassword(
                            email: widget.email,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );

                          if (response != null &&
                              response['status'] == 200) {
                            Utils.flushBarSuccessMessage(
                                response['msg'] ?? "Password changed",
                                context);

                            // Navigation after successful password reset
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesName.login,
                                  (route) => false,
                            );
                          } else {
                            Utils.flushBarErrorMessage(
                                response?['msg'] ??
                                    "Something went wrong",
                                context);
                          }
                        }
                      },
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
