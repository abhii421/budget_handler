import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category {food, stationary, misc, clothing}

final formatter = DateFormat.yMd();


const categoryIcons = {
  Category.food : Icons.lunch_dining_sharp,
  Category.stationary : Icons.note_add_sharp,
  Category.clothing : Icons.accessibility_new_rounded,
  Category.misc : Icons.account_balance_wallet
};

class Expense {

   Expense({required this.title, required this.amount, required this.date, required this.category}) : id = uuid.v4();
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get FormattedDate{
    return formatter.format(date);
    }
}

class ExpenseBucket{

  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
  : expenses = allExpenses.where((expense) => expense.category == category).toList();
  //37 and 38 line not understood

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses{
    double sum = 0;

    for(final expense in expenses){
      sum = sum+ expense.amount;
    }
    return sum;
  }

}