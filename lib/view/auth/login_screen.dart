import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/utils/routes/routes_name.dart';
import 'package:planto/utils/utils.dart';
import 'package:planto/view/auth/sign_up.dart';
import '../../view_model/auth_view_model.dart';
import '../../widgets/custom_fields.dart';
import '../bottom_nav_bar.dart';
import 'forgot_password.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  bool _rememberMe = false;
  bool isLoading = false;

  AuthViewModel _authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),

                Center(
                  child: Image.asset(
                    'asset/logo.png',
                    height: 160.h,
                    width: 250.w,
                  ),
                ),

                Center(
                  child: Text(
                    'Welcome Back!',
                    style: GoogleFonts.montserrat(
                      color: Colors.green.shade500,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Text(
                    'Log in to continue',
                    style: TextStyle(fontSize: 17.sp),
                  ),
                ),
                SizedBox(height: 30.h),

                CustomField(
                  controller: _emailController,
                  hint: 'enter your email',
                  labText: 'Email',
                  suffix: isLoading ? Icon(Icons.check) : Icon(Icons.email),
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 18.h),
                ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (_, value, child) {
                    return CustomField(
                      controller: _passwordController,
                      hint: 'enter your password',
                      labText: 'Password',
                      isObscure: _obsecurePassword.value,

                      suffix: InkWell(
                        onTap: () {
                          _obsecurePassword.value = !_obsecurePassword.value;
                        },
                        child:
                            _obsecurePassword.value
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                      ),
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    );
                  },
                ),

                SizedBox(height: 8.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          activeColor:
                              isLoading
                                  ? Color(0xFF3A3A3A)
                                  : Colors.green.shade500,

                          onChanged: (val) {
                            setState(() => _rememberMe = val!);
                          },
                        ),
                        Text(
                          'Remember me',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF3A3A3A),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.forgot);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                          'Please enter E-mail',
                          context,
                        );
                      } else if (_passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                          'Please enter Password',
                          context,
                        );
                      } else if (_passwordController.text.length < 8) {
                        Utils.flushBarErrorMessage(
                          'Password should be at least 8 characters, contain 1 capital, 1 small letter, 1 special character and 1 number',
                          context,
                        );
                      } else {
                        print('api hit');

                        Map<String, String> data = {
                          'email': _emailController.text.trim(),
                          'password': _passwordController.text.trim(),
                        };

                        _authViewModel.loginApi(data, context);
                      }
                    },

                    child: Text(
                      'Log In',

                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignupScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF3A3A3A),
                          ),
                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.green,
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
        ),
      ),
    );
  }
}
