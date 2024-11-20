import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/expense_controller.dart';

class ExpenseLineChart extends StatelessWidget {
  const ExpenseLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    String getWeekdayName(double value) {
      final weekdays = ['Su', 'M', 'T', 'W', 'Th', 'F', 'Sa'];
      return weekdays[value.toInt() % 7];
    }

    List<FlSpot> getSpots(
        List<Map<String, dynamic>> transactions, String type) {
      // Initialize a fixed-size list for all weekdays with 0.0 as default value
      List<double> weekdayTotals = List.filled(7, 0.0);

      // Sum up transactions for each weekday
      for (var transaction in transactions) {
        if (transaction['type'] == type) {
          final date = transaction['date'] as DateTime;
          // Convert to 0-based week (0 = Sunday, 1 = Monday, etc.)
          final weekdayIndex = date.weekday % 7;
          weekdayTotals[weekdayIndex] += transaction['amount'].toDouble();
        }
      }

      // Convert to FlSpots
      return List.generate(7, (index) {
        return FlSpot(index.toDouble(), weekdayTotals[index]);
      });
    }

    final ExpenseController controller = Get.find();

    return Obx(() {
      final incomeSpots = getSpots(controller.transactions, 'Income');
      final expenseSpots = getSpots(controller.transactions, 'Expense');

      return AspectRatio(
        aspectRatio: 1.5,
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(
              show: false,
              drawHorizontalLine: false,
              drawVerticalLine: false,
            ),
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        getWeekdayName(value),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
              border: Border.all(color: Colors.grey.shade300),
            ),
            minX: 0,
            maxX: 6,
            lineBarsData: [
              LineChartBarData(
                spots: incomeSpots,
                preventCurveOverShooting: true,
                isCurved: true,
                color: Colors.green,
                barWidth: 3,
                dotData: const FlDotData(
                  show: true,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.green.withOpacity(0.1),
                ),
              ),
              // Expense line
              LineChartBarData(
                spots: expenseSpots,
                isCurved: true,
                color: Colors.red,
                barWidth: 3,
                dotData: const FlDotData(
                  show: true,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.red.withOpacity(0.1),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final type = barSpot.barIndex == 0 ? 'Income' : 'Expense';
                    return LineTooltipItem(
                      '$type\n${barSpot.y.toInt()}',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
