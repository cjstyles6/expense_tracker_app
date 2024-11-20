import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class TotalExpenseCard extends StatelessWidget {
  const TotalExpenseCard({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseController controller = Get.find();
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF3790DA),
            Color(0xFFF03DD8),
            Color(0xFFFFB545),
          ],
        ),
      ),
      child: Column(
        children: [
          const Text('Total Balance').fontSize(25).textColor(Colors.white),
          5.heightBox,
          Obx(
            () => Text('₦ ${controller.getBalance().toStringAsFixed(2)}')
                .fontSize(40)
                .bold()
                .textColor(Colors.white),
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Ionicons.arrow_up_outline,
                      color: Colors.green,
                    ),
                  ),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Income').fontSize(16).textColor(Colors.white),
                      Obx(
                        () => Text(
                          controller.totalIncome.toStringAsFixed(2),
                        ).fontSize(20).textColor(Colors.white).bold(),
                      )
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Ionicons.arrow_down_outline,
                      color: Colors.red,
                    ),
                  ),
                  10.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Expense')
                          .fontSize(16)
                          .textColor(Colors.white),
                      Obx(
                        () => Text(
                          controller.totalExpense.toStringAsFixed(2),
                        ).fontSize(20).textColor(Colors.white).bold(),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
