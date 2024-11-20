import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddExpensesController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(DateTime.now());
  Rx<List<CoolDropdownItem>> currentCategoryList =
      Rx<List<CoolDropdownItem>>([]);

  final amountController = TextEditingController();
  final noteController = TextEditingController();

  RxString selectedType = 'Income'.obs;
  RxString selectedCategory = ''.obs;

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  List<CoolDropdownItem> selectType = [
    CoolDropdownItem(label: 'Income', value: 'Income'),
    CoolDropdownItem(label: 'Expense', value: 'Expense'),
  ];

  List<CoolDropdownItem> selectIncome = [
    CoolDropdownItem(label: 'Salary', value: 'Salary'),
    CoolDropdownItem(label: 'Business', value: 'Business'),
    CoolDropdownItem(label: 'Gift', value: 'Gift'),
    CoolDropdownItem(label: 'Bonuses', value: 'Bonuses'),
    CoolDropdownItem(label: 'Others', value: 'Others'),
  ];

  List<CoolDropdownItem> selectExpenses = [
    CoolDropdownItem(label: 'Food & Groceries', value: 'Food & Groceries'),
    CoolDropdownItem(label: 'Transportation', value: 'Transportation'),
    CoolDropdownItem(label: 'Rent', value: 'Rent'),
    CoolDropdownItem(label: 'Entertainment', value: 'Entertainment'),
    CoolDropdownItem(label: 'Healthcare', value: 'Healthcare'),
    CoolDropdownItem(label: 'Others', value: 'Others'),
  ];

  @override
  void onInit() {
    currentCategoryList.value = selectIncome;
    super.onInit();
  }

  @override
  void onClose() {
    amountController.dispose();
    noteController.dispose();
    super.onClose();
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime day) {
        return day.isBefore(DateTime.now()) ||
            day.isAtSameMomentAs(DateTime.now());
      },
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }

  String getFormattedDate() {
    if (selectedDate.value == null) return 'Today';
    DateTime date = selectedDate.value!;
    String year = date.year.toString();
    String month = months[date.month - 1];
    String day = date.day.toString();
    return '$year-$month-$day';
  }

  void updateCategoryList(String type) {
    selectedType.value = type;
    if (type == 'Income') {
      currentCategoryList.value = selectIncome;
    } else if (type == 'Expense') {
      currentCategoryList.value = selectExpenses;
    }
    selectedCategory.value = '';
  }

  Future<bool> addExpenses() async {
    try {
      if (amountController.text.isEmpty) {
        Get.snackbar('Error', 'Please enter an amount');
        return false;
      }

      if (selectedCategory.value.isEmpty) {
        Get.snackbar('Error', 'Please select a category');
        return false;
      }

      final amount = int.parse(amountController.text);
      final data = ExpenseController.instance;

      await data.addData(
        amount,
        selectedDate.value ?? DateTime.now(),
        noteController.text,
        selectedType.value,
        selectedCategory.value,
      );

      Get.back();
      Get.snackbar('Success', 'Transaction added successfully');
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to add transaction: $e');
      return false;
    }
  }
}
