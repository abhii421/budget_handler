import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/widgets/expenses.dart';


class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

// String expenseName = '';
// void SaveTitle(inputtedValue){
//     expenseName = inputtedValue;
// }

class _NewExpenseState extends State<NewExpense> {

  List<Expense> mylist = [
    Expense(title: 'expense 1', amount: 50, date: DateTime(2024), category: Category.clothing),
    Expense(title: 'expense 2', amount: 700, date: DateTime(2023), category: Category.clothing),
  ];


  final _ExpenseNameController = TextEditingController();
  final _ExpenseAmount = TextEditingController();
  Category _selectedCategory = Category.clothing;
  DateTime? _selectedDate;
  bool allgood = true;
  //generally it is a good practise to use an underscore in case of text controllers
  //so that it is not reused in other dart files




  void _ShowDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(context: context,
        firstDate: DateTime(2022),
        initialDate: now,
        lastDate: DateTime(2025));

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void addExpensee(Expense expense){
    setState(() {
      mylist.add(expense);
    });

  }


  void show_InvalidExpenseAmt(){
    if(Platform.isIOS){
      showCupertinoDialog(context: context, builder: (ctx) => CupertinoAlertDialog(
        title: Text('Invalid Expense Amount'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
            },
              child: Text('Okay')
          )
        ],
      ),
    );
    }
    else{
      showDialog(context: context, builder: (cntxt) => AlertDialog(
        title: Text('Invalid Expense amount'),
        content: Text('Non numerical Amount'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(cntxt);
          },
              child: Text('Okay')
          )
        ],
      ),
      );
    }
  }




  void _submitExpenseData(){

    final enteredAmount = double.tryParse(_ExpenseAmount.text);
    //if the entered amount is not a digit then the parsing/or type conversion
    //gives a null value as result


    if(enteredAmount == null)
      {
          show_InvalidExpenseAmt();
      }


    if(enteredAmount!=null)
    {
      if (enteredAmount <= 0 || _ExpenseNameController.text.trim().isEmpty)
        {
          showCupertinoDialog(context: context, builder: (ctx) => CupertinoAlertDialog(
              title: Text('Invalid Amount or Name')
          )
            );

          showDialog(
            context: context, builder: (ctxx) => AlertDialog(
              title: Text('Invalid Amount or Name'),
              content: Text('Expense Amount/Name is Zero or Invalid'),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(ctxx);
              },
                  child: Text('Okay'))
            ],
          ),
          );
        }
      
      if(_selectedDate == null)
        {
          showDialog(context: context, builder: (cttx) => AlertDialog(
            title: Text('Invalid/No date'),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(cttx);
                },
                  child: Text('Okay'))
            ],
          ));
        }

      if(enteredAmount > 0 && _ExpenseNameController.text.trim().isNotEmpty && _selectedDate!= null)
        {
          print('Both Forms are good');
          widget.onAddExpense(Expense(title: _ExpenseNameController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
          //addExpensee(Expense(title: _ExpenseNameController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
          //print(mylist);

         Navigator.pop(context);
        }
    }
    
  }


  @override
  void dispose() {
    _ExpenseNameController.dispose();
    _ExpenseAmount.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.fromLTRB(12,12,12,12),
      child: Form(

        child: Column(
          children: [
            SizedBox(height : 60),
            TextField(
              //onChanged: SaveTitle,
              controller: _ExpenseNameController,
              maxLength: 50,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10)
                    ,label: Text('Expense Name')
              ),
            ),

            SizedBox(height : 10),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    //onChanged: SaveTitle,
                    //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 50,
                    keyboardType: TextInputType.number,
                    controller: _ExpenseAmount,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
                    decoration: InputDecoration(
                      prefixText: '₹ ',
                        contentPadding: EdgeInsets.all(10),
                        label: Text('₹')
                    ),
                  ),
                ),

                SizedBox(width : 10),

                Expanded(child: Row(

                  children: [
                  Text(_selectedDate == null ? 'Not Selected' : formatter.format(_selectedDate!)),
                    IconButton(onPressed: (){
                      _ShowDatePicker();
                      },
                        icon: Icon(Icons.calendar_month))
                ],
                )
                )

              ],
            ),

            SizedBox(height : 10),
            Row(
              children: [
                 SizedBox(width : 10),

                  SizedBox(width: 10,),
                  Spacer(),
                  DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child : Text(category.name.toUpperCase())
                )
                ).toList(),

                  onChanged: (value) {

                    if(value==null)
                      {
                        return;
                      }


                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                ,

                ),
              ],
            ),
            SizedBox(height : 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               // SizedBox(width : 20),
                ElevatedButton(onPressed: (){
                  _submitExpenseData();

                },
                    child: Text('Save', style: TextStyle(fontSize: 20),)
                ),
                  //Spacer(),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                },
                    child: Text('Cancel', style: TextStyle(fontSize: 20))
                ),
               // SizedBox(height : 50),
              ],
            ),

          ],
        ),
      ),
    );
  }
}



// if(_ExpenseNameController.text.trim().isEmpty)
//   {
//     showDialog(context: context, builder: (ctx) => AlertDialog(
//       title: Text('Invalid Name'),
//       content: Text('Expense Name is empty'),
//       actions: [
//         TextButton(onPressed: (){
//           Navigator.pop(ctx);
//         },
//             child: Text('Okay'))
//       ],
//     ),
//     );
//   }



