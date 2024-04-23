import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense,{super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      expense.title,
                      style : Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height : 8),
                  Row(
                    children: [
                      Text('₹${expense.amount.toStringAsFixed(2)}'),
                      Spacer(),
                      Row(
                        children: [
                          Icon(categoryIcons[expense.category]),
                          SizedBox(height : 8),
                          Text(expense.FormattedDate)
                        ],
                      )
                    ],
                  )
                ],
              )),

    );
  }
}
