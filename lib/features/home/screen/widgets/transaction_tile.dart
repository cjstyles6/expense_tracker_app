import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TransactionTile extends StatelessWidget {
  final Map<String, dynamic> transaction;
  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isIncome = transaction['type'] == 'Income';
    final DateTime date = transaction['date'];
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              isIncome
                  ? Ionicons.arrow_up_outline
                  : Ionicons.arrow_down_outline,
              size: 30,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
          10.widthBox,
          Text(transaction['category'])
              .fontSize(20)
              .fontWeight(FontWeight.w500),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : '-'}\$${transaction['amount']}',
              )
                  .fontSize(25)
                  .textColor(isIncome ? Colors.green : Colors.red)
                  .fontWeight(FontWeight.w500),
              Text('${date.day}/${date.month}/${date.year}')
                  .fontSize(14)
                  .textColor(Colors.grey)
            ],
          ),
        ],
      ),
    );
  }
}
