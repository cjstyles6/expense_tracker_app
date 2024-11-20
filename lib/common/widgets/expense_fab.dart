import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../routes/app_routes.dart';

class ExpenseFab extends StatelessWidget {
  const ExpenseFab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.ADD),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF3790DA),
              Color(0xFFF03DD8),
              Color(0xFFFFB545),
            ],
          ),
        ),
        child: const Icon(Ionicons.add_outline, size: 40, color: Colors.white),
      ),
    );
  }
}
