import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:expense_tracker_app/features/add_expenses/controller/add_expenses_controller.dart';
import 'package:get/get.dart';

class ExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddExpensesController>(() => AddExpensesController());
    Get.lazyPut<ExpenseController>(() => ExpenseController());
  }
}
