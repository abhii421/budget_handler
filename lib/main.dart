import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kCOlorScheme = ColorScheme.fromSeed(seedColor: Colors.purpleAccent.withOpacity(0.9));


void main() {
  runApp(

      MaterialApp(

          debugShowCheckedModeBanner: false,

          theme : ThemeData().copyWith(
            colorScheme: kCOlorScheme,
            cardTheme: CardTheme().copyWith(
              elevation: 7,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: 7,horizontal: 10),
            ),
            textTheme: ThemeData().textTheme.copyWith(
              titleMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight:FontWeight.w600
              )
            )
          ),

          home : Expenses()
      )
  );
}

