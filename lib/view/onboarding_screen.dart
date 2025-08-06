import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../view_model/onboarding_view_model.dart';
import 'auth/sign_up.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F3EC),
      body: Consumer<OnboardingViewModel>(
        builder: (context, onboardingVM, child) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: onboardingVM.pageController,
                      itemCount: onboardingVM.onBoardImages.length,
                      onPageChanged: onboardingVM.updateIndex,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              onboardingVM.onBoardImages[index],
                              height: 300.h,
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              onboardingVM.onboardingTexts[index],
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 98),
                    child: SmoothPageIndicator(
                      controller: onboardingVM.pageController,
                      count: onboardingVM.onBoardImages.length,
                      effect: WormEffect(
                        activeDotColor: Color(0xff163223),
                        dotColor: Colors.grey.shade400,
                        dotHeight: 10.h,
                        dotWidth: 10.h,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 48.h,
                right: 18.w,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>  SignupScreen()));
                  },
                  child: Text(
                    'Skip ',
                    style: GoogleFonts.notoSans(fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(1, 1.5),
                          blurRadius: 4,
                        ),
                      ],
                    )

                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
