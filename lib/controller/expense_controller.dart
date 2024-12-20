import 'package:expense_tracker_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ExpenseController extends GetxController {
  static ExpenseController get instance => Get.find();

  late Box box;

  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpense = 0.0.obs;
  RxDouble balance = 0.0.obs;
  RxList<Map<String, dynamic>> transactions = <Map<String, dynamic>>[].obs;

  final List<String> incomeCategories = [
    'Salary',
    'Business',
    'Gift',
    'Bonuses',
    'Others',
  ];

  final List<String> expenseCategories = [
    'Food & Groceries',
    'Transportation',
    'Rent',
    'Entertainment',
    'Healthcare',
    'Others',
  ];

  @override
  void onInit() {
    box = Hive.box('expenses');
    calculateTotals();
    loadTransactions();
    super.onInit();
  }

  Future<bool> addData(
    int amount,
    DateTime date,
    String note,
    String type,
    String category,
  ) async {
    try {
      await box.add({
        'amount': amount.toDouble(),
        'date': date,
        'note': note,
        'type': type,
        'category': category,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      calculateTotals();
      loadTransactions();
      return true;
    } catch (e) {
      debugPrint('Error adding data: $e');
      return false;
    }
  }

  // New method to delete a transaction
  Future<bool> deleteTransaction(int timestamp) async {
    try {
      // Find the index of the transaction to delete
      final index = box.values
          .toList()
          .indexWhere((transaction) => transaction['timestamp'] == timestamp);

      if (index == -1) {
        debugPrint('Transaction not found');
        return false;
      }

      // Delete the transaction
      await box.deleteAt(index);

      // Recalculate totals and reload transactions
      calculateTotals();
      loadTransactions();
      return true;
    } catch (e) {
      debugPrint('Error deleting transaction: $e');
      return false;
    }
  }

  void calculateTotals() {
    double income = 0;
    double expense = 0;

    for (var entry in box.values) {
      // Safely retrieve 'amount' and cast it to double
      var amount = entry['amount'] is int
          ? (entry['amount'] as int).toDouble()
          : (entry['amount'] as double);

      if (entry['type'] == 'Income') {
        income += amount;
      } else if (entry['type'] == 'Expense') {
        expense += amount;
      }
    }

    totalIncome.value = income;
    totalExpense.value = expense;
    balance.value = income - expense; // Update reactive balance
  }

  void loadTransactions() {
    final transactionList = box.values.toList()
      ..sort((a, b) => (b['timestamp'] ?? 0).compareTo(a['timestamp'] ?? 0));

    transactions.value =
        transactionList.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  double getBalance() {
    return balance.value;
  }

  Map<String, double> calculateCategoryPercentages() {
    Map<String, double> categoryTotals = {};
    double total = totalIncome.value + totalExpense.value;

    for (var entry in box.values) {
      String category = entry['category'];
      double amount = entry['amount'].toDouble();

      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] = categoryTotals[category]! + amount;
      } else {
        categoryTotals[category] = amount;
      }
    }

    // Convert amounts to percentages
    categoryTotals.updateAll((key, value) => (value / total) * 100);

    return categoryTotals;
  }

  // Navigation
  Rx<int> selectedIndex = Rx<int>(0);
  void changeSelectedIndex(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.HOME);
      case 1:
        Get.toNamed(AppRoutes.STATISTICS);
      default:
    }
    update();
  }
}
