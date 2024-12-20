import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:expense_tracker_app/controller/expense_controller.dart';
import 'package:expense_tracker_app/features/home/screen/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class ViewAllTransactionsScreen extends StatelessWidget {
  const ViewAllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ExpenseController controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  5.widthBox,
                  const Text('All Transactions').fontSize(20).bold(),
                ],
              ),
              10.heightBox,
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(15),
                                icon: Icons.delete,
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.red,
                                onPressed: (context) =>
                                    controller.deleteTransaction(
                                  controller.transactions[index]['timestamp'],
                                ),
                              ),
                            ],
                          ),
                          child: TransactionTile(
                            transaction: controller.transactions[index],
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
