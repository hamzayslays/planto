import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_fields.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  AuthViewModel _authViewModel = AuthViewModel();



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Center(
              child: Image.asset('asset/logo.png', height: 180, width: 220),
            ),
            const SizedBox(height: 10),
            Text(
              'Sign Up',
              style: GoogleFonts.montserrat(
                fontSize: 35,
                color: Colors.green.shade400,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            CustomField(
              controller: _nameController,
              hint: 'Enter Your Name',
              labText: 'Name',
              suffix: Icon(Icons.person),
              valid: (value) {
                if (value == null || value.isEmpty) return 'Name is required';

                return null;
              },
            ),
            SizedBox(height: 10),

            // Email Field
            CustomField(
              controller: _emailController,
              hint: 'Enter Your Email',
              labText: 'Email',
              suffix: Icon(Icons.email_outlined),
              valid: (value) {
                if (value == null || value.isEmpty) return 'Email is required';
              },
            ),
            SizedBox(height: 10.h),

            // Password Field
            CustomField(
              controller: _passwordController,
              hint: 'Enter Your Password',
              labText: 'Password',
              suffix: Icon(Icons.lock),
              valid: (value) {
                if (value == null || value.isEmpty)
                  return 'Password is required';
                if (value.length < 6)
                  return 'Password must be at least 6 characters';

                return null;
              },
            ),

            SizedBox(height: 10.h),

            // Confirm Password Field
            CustomField(
              controller: _confirmPasswordController,
              hint: 'Enter Your Confirm Password',
              labText: 'Confirm Password',
              suffix: Icon(Icons.lock),
              valid: (value) {
                if (value == null || value.isEmpty)
                  return 'Confirm password is required';
                if (value != _passwordController.text)
                  return 'Passwords do not match';
                return null;
              },
            ),

            SizedBox(height: 30.h),

            // Sign Up Button (with loading indicator)
            InkWell(
              onTap: () {
                Map<String, String> data = {
                  'name': _nameController.text.toString(),
                  'email': _emailController.text.toString(),
                  'password': _passwordController.text.toString(),
                  'confirmPassword': _confirmPasswordController.text.toString(),
                };

                _authViewModel.signUpApi(data, context);


              },
              child: CustomButtons(name: 'Sign up', loading: loading),
            ),

            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Loginscreen()),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF3A3A3A),
                      ),
                    ),
                    Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.green.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
