import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        automaticallyImplyLeading: false,
        title: Text('My Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// Profile Picture
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.r),
                child: Image.asset(
                  'asset/eco.png',
                  height: 100.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            /// Name
            Text(
              'Muhammad Hamza',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),

            /// Email
            Text(
              'hamza@email.com',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
            ),

            SizedBox(height: 20.h),

            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 35.w),
                    child: Container(
                      height: 38,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ), Padding(
                    padding: EdgeInsets.only(right: 35.w),
                    child: Container(
                      height: 38,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          'share Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

          ],
        ),
      ),
    );
  }
}
