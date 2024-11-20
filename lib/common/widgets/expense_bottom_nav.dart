import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ExpenseBottomNav extends StatelessWidget {
  const ExpenseBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseController controller = Get.put(ExpenseController());
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.changeSelectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                controller.selectedIndex.value == 0
                    ? Ionicons.card
                    : Ionicons.card_outline,
                size: 30,
                color: controller.selectedIndex.value == 0
                    ? Colors.purple
                    : Colors.black,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                controller.selectedIndex.value == 1
                    ? Ionicons.stats_chart
                    : Ionicons.stats_chart_outline,
                size: 30,
                color: controller.selectedIndex.value == 1
                    ? Colors.purple
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
