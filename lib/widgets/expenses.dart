import 'package:expense_tracker/widgets/overlay_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  List<Expense> _mylist = [
    Expense(title: 'expense 1', amount: 50, date: DateTime(2024), category: Category.clothing),
    Expense(title: 'expense 2', amount: 700, date: DateTime(2023), category: Category.clothing),
  ];


  void _openModalOverlay(){
    showModalBottomSheet(context: context,
        builder: (ctx){
      return NewExpense();}
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [
            IconButton(onPressed:
              _openModalOverlay
      ,
              icon: Icon(Icons.add))]),
      body: Column(
        children: [
          Expanded(
              child: ExpensesList(expenseskaList: _mylist)
          )
        ],
      ),
    );
  }
}
