import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenseskaList, required this.onRemoveExpense});

  final List<Expense> expenseskaList;
  final void Function(Expense expense) onRemoveExpense;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: expenseskaList.length,
        itemBuilder: (ctx,index)
        {
          return Dismissible(key: ValueKey(expenseskaList[index]),
              onDismissed: (direction) {
                  onRemoveExpense(expenseskaList[index]);
              },
              child: ExpenseItem(expenseskaList[index])
          );
    });
  }
}
