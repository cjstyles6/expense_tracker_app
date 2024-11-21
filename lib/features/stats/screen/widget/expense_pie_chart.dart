import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../controller/expense_controller.dart';

class ExpensePieChart extends StatelessWidget {
  const ExpensePieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseController = ExpenseController.instance;

    final categoryPercentages =
        expenseController.calculateCategoryPercentages();

    // Group small categories into 'Others'
    double othersPercentage = 0.0;
    final filteredCategories = categoryPercentages.entries
        .where((entry) => entry.value >= 5.0)
        .toList();

    for (var entry in categoryPercentages.entries) {
      if (entry.value < 5.0) {
        othersPercentage += entry.value;
      }
    }

    // Add 'Others' category if necessary
    if (othersPercentage > 0) {
      filteredCategories.add(MapEntry('Others', othersPercentage));
    }

    // Create sections for the PieChart
    final List<PieChartSectionData> sections = filteredCategories.map((entry) {
      final isIncome = expenseController.incomeCategories.contains(entry.key);

      return PieChartSectionData(
        color: isIncome ? Colors.green : Colors.red,
        value: entry.value,
        title: '${entry.key}\n${entry.value.toStringAsFixed(0)}%',
        radius: 150,
        titleStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
        ),
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        centerSpaceRadius: 40,
        sectionsSpace: 4,
        borderData: FlBorderData(show: false),
        pieTouchData: PieTouchData(
          touchCallback: (touchEvent, response) {
            if (touchEvent is PieTouchResponse) {
              // Handle interactions on tap (e.g., show details in a modal or bottom sheet)
              if (response?.touchedSection != null) {
                // Show detailed information on tapped section (optional)
                // print('Touched section: ${response?.touchedSection!.title}');
              }
            }
          },
        ),
      ),
    );
  }
}
