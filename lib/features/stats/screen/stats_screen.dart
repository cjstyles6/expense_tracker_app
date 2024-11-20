import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:expense_tracker_app/features/stats/screen/widget/expense_pie_chart.dart';
import 'package:expense_tracker_app/features/stats/screen/widget/expense_line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/expense_bottom_nav.dart';
import '../../../common/widgets/expense_fab.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Text('Transactions').fontSize(25).bold().toCenter(),
                20.heightBox,
                const ExpenseLineChart(),
                SizedBox(
                  height: 350.h,
                  child: const ExpensePieChart(),
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
