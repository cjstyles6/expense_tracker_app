import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3790DA),
            Color(0xFFF03DD8),
            Color(0xFFFFB545),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                30.heightBox,
                const Text(
                  'Welcome to EasyTrack! Manage your expenses effortlessly and stay on top of your finances',
                  textAlign: TextAlign.center,
                ).fontSize(18.sp).bold().textColor(Colors.white),
                50.heightBox,
                Image.asset(
                  'assets/wallet-icon.png',
                ),
                50.heightBox,
                const Text('Easy Track')
                    .fontSize(25.sp)
                    .textColor(Colors.white),
                30.heightBox,
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: const Text('Continue').bold()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
