import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:expense_tracker_app/common/widgets/expense_bottom_nav.dart';
import 'package:expense_tracker_app/common/widgets/expense_fab.dart';
import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:expense_tracker_app/features/home/screen/widgets/total_expense_card.dart';
import 'package:expense_tracker_app/features/home/screen/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:random_avatar/random_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseController controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    RandomAvatar('john doe', width: 50, height: 50),
                    5.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome!').fontSize(16.sp),
                        const Text('John Doe').fontSize(20.sp).bold(),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Ionicons.log_out_outline,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                20.heightBox,
                const TotalExpenseCard(),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Recent Transactions').fontSize(20).bold(),
                  ],
                ),
                10.heightBox,
                Obx(
                  () {
                    final transactions = controller.transactions;
                    if (transactions.isEmpty) {
                      return SizedBox(
                        height: 300.h,
                        child: Center(
                          child: const Text('No transactions yet')
                              .textColor(Colors.black)
                              .fontSize(30.sp),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          transactions.length > 5 ? 5 : transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TransactionTile(
                          transaction: transactions[index],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ExpenseFab(),
      bottomNavigationBar: const ExpenseBottomNav(),
    );
  }
}
