import 'dart:async';

import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;
  Timer? _autoPageTimer;


  final List<String> onBoardImages =[
    'asset/homePlant.png',
    'asset/care.png',
    'asset/eco.png'
  ];

  final List<String> onboardingTexts = [
    'Bring Plants and Nature Into\n Home',
    'Learn to Care for Your Indoor Plants',
    'Get Fresh Greenery Delivered to Your Door',
  ];

  OnboardingViewModel() {
    startAutoPage();
  }


  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void startAutoPage(){
    _autoPageTimer?.cancel();
    _autoPageTimer = Timer.periodic(Duration(seconds: 2), (timer){
      if(currentIndex < onBoardImages.length - 1){
        currentIndex++;
        pageController.animateToPage(currentIndex,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }else{
        _autoPageTimer?.cancel();
      }
      notifyListeners();
    }

    );
  }


  void skipOnboarding(BuildContext context) {
    // Navigate to your Home/Login Screen
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  void continueToNextScreen(BuildContext context) {
    // Navigate to your Home/Login Screen
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  void dispose() {
    _autoPageTimer?.cancel() ;
    pageController.dispose();
    super.dispose();
  }
}
