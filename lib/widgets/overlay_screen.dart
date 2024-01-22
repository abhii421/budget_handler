import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/services.dart';


class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

// String expenseName = '';
// void SaveTitle(inputtedValue){
//     expenseName = inputtedValue;
// }

class _NewExpenseState extends State<NewExpense> {

  final _ExpenseNameController = TextEditingController();
  final _ExpenseAmount = TextEditingController();
  Category _selectedCategory = Category.clothing;
  DateTime? _selectedDate;
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



  void _submitExpenseData(){

    final enteredAmount = double.tryParse(_ExpenseAmount.text);
    //if the entered amount is not a digit then the parsing/or type conversion
    //gives a null value as result


    if(enteredAmount == null)
      {
          showDialog(context: context, builder: (cntxt) => AlertDialog(
            title: Text('Invalid Expense amount'),
            content: Text('Non numerical Amount'),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(cntxt);
              },
                  child: Text('Okay'))
            ],
          ),
          );
      }


    if(enteredAmount!=null)
    {
      if (enteredAmount <= 0)
        {
          showDialog(
            context: context, builder: (ctxx) => AlertDialog(
              title: Text('Invalid Amount'),
              content: Text('Expense Amount is Zero or Invalid'),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(ctxx);
              },
                  child: Text('Okay'))
            ],
          ),
          );
        }
    }

    if(_ExpenseNameController.text.trim().isEmpty)
      {
        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text('Invalid Name'),
          content: Text('Expense Name is empty'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(ctx);
            },
                child: Text('Okay'))
          ],
        ),
        );
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
      padding: EdgeInsets.all(10),
      child: Form(

        child: Column(
          children: [
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
                    }, icon: Icon(Icons.calendar_month))
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
                            child : Text(
                                category.name.toUpperCase()
                            )
                )
                ).toList(),

                  onChanged: (value) {
                    if(value!= null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                },

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
