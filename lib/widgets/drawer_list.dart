import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/onboarding_screen.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green.shade500,
          ),
          accountName: Text(
            "Muhammad Hamza",
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text(
            "hamza@email.com",
            style: GoogleFonts.poppins(fontSize: 13.sp),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage("asset/eco.png"),
          ),
        ),
        _buildDrawerItem(Icons.home, "Home", () {
          Navigator.pop(context);
        }),
        _buildDrawerItem(Icons.person, "My Profile", () {

        }),
        _buildDrawerItem(Icons.shopping_cart, "My Orders", () {}),
        _buildDrawerItem(Icons.favorite, "Favorites", () {

        }),
        _buildDrawerItem(Icons.settings, "Settings", () {}),
        _buildDrawerItem(Icons.info, "About", () {}),
        const Divider(),
        _buildDrawerItem(Icons.logout, "Logout", () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogin', false);

          // Drawer close karna (optional)
          Navigator.pop(context);

          // Redirect to Onboarding/Login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const OnboardingScreen()),
          );
        }, color: Colors.red),

      ],
    );
  }
}
Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap,
    {Color? color}) {
  return ListTile(
    leading: Icon(icon, color: color ?? Colors.green.shade500),
    title: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: color ?? Colors.black87,
      ),
    ),
    onTap: onTap,
  );
}
