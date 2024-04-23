import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/overlay_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  //, required this.onAddExpense
  //final void Function (Expense expense) onAddExpense;

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {

  List<Expense> mylist = [
    Expense(title: 'expense 1', amount: 50, date: DateTime(2024), category: Category.clothing),
    Expense(title: 'expense 2', amount: 700, date: DateTime(2023), category: Category.clothing),
  ];


  void _openModalOverlay(){
    showModalBottomSheet(
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (ctx){
      return NewExpense(onAddExpense: addExpense,);
    }
    );
  }


  void addExpense(Expense expense){
    setState(() {
      mylist.add(expense);
    });
  }

  void removeExpense(Expense expense)
  {
    int expenseIndex = mylist.indexOf(expense);

    setState(() {
      mylist.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Expense Removed'),
          duration: Duration(seconds: 3),
          action : SnackBarAction(label: 'Undo',
              onPressed: (){
                setState(() {
                  mylist.insert(expenseIndex, expense);
                });
              }
          )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
  final device_width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
          title: Text('Expense Tracker'),
          centerTitle: true,
          titleSpacing: 50,
          actions: [
            IconButton(onPressed:
              _openModalOverlay,
              icon: Icon(Icons.add))]),



      body: device_width < 600 ? Column(
        children: [
          Chart(expenses: mylist),
          Expanded(
              child: ExpensesList(expenseskaList: mylist, onRemoveExpense: removeExpense,)
          )
        ],
      ) :

      Row(
        children: [
          Expanded(
              child: Chart(expenses: mylist)
          ),
          Expanded(
              child: ExpensesList(expenseskaList: mylist, onRemoveExpense: removeExpense,)
          )
        ],
      )
    );
  }
}
