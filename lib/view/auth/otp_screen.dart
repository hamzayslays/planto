import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planto/utils/utils.dart';
import 'package:planto/view_model/otp_view_model.dart';
import 'package:planto/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  // 6 text controllers and focus nodes for 6 OTP boxes
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(6, (_) => TextEditingController());
    focusNodes = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OtpViewModel(),
      child: Consumer<OtpViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter OTP',
                    style: GoogleFonts.montserrat(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "OTP sent to: ${widget.email}",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  const SizedBox(height: 20),

                  // OTP boxes row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 40,
                        child: TextField(
                          controller: controllers[index],
                          focusNode: focusNodes[index],
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(
                                context,
                              ).requestFocus(focusNodes[index + 1]);
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 30),

                  CustomButtons(
                    name: viewModel.isLoading ? 'Verifying...' : 'Verify',
                    onPressed: () {
                      String otp = controllers.map((c) => c.text).join();
                      if (otp.length < 6) {
                        Utils.flushBarErrorMessage(
                          "Please enter all 6 digits",
                          context,
                        );
                        return;
                      }

                      viewModel.verifyOtp(
                        context: context,
                        email: widget.email,
                        otp: otp,
                      );
                    },
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
