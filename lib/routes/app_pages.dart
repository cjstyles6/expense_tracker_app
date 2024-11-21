import 'package:expense_tracker_app/bindings/expense_binding.dart';
import 'package:expense_tracker_app/features/add_expenses/screen/add_expenses_screen.dart';
import 'package:expense_tracker_app/features/home/screen/home_screen.dart';
import 'package:expense_tracker_app/features/home/screen/view_all_transactions_screen.dart';
import 'package:expense_tracker_app/features/stats/screen/stats_screen.dart';
import 'package:expense_tracker_app/features/welcome/screen/welcome_screen.dart';
import 'package:expense_tracker_app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: ExpenseBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.ADD,
      page: () => const AddExpensesScreen(),
      transition: Transition.downToUp,
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: AppRoutes.STATISTICS,
      page: () => const StatsScreen(),
      binding: ExpenseBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.TRANSACTIONS,
      page: () => const ViewAllTransactionsScreen(),
      binding: ExpenseBinding(),
      // transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.WELCOME,
      page: () => const WelcomeScreen(),
      // binding: ExpenseBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
