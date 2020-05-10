import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transaction.dart';

class NewTransaction extends StatefulWidget {

  final Function addTransaction;


  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleCont = TextEditingController();
  final amountCont = TextEditingController();
  DateTime selectedDate;

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now()
    ).then((date){
      if(date == null){
        return;
      }
      setState(() {
        selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 5,
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    
                    TextField(
                      controller: titleCont,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: "Title",
                      ),
                    ),
                    TextField(
                      controller: amountCont,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Amount",
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Text(
                            selectedDate  != null ? DateFormat.yMd().format(selectedDate) : 'No date chosen!'
                            ),
                          FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              "Choose Date",
                              style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            onPressed: _presentDatePicker,
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text("Add Transcation"),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: (){
                        widget.addTransaction(
                          Transaction(
                            title: titleCont.text,
                            amount: amountCont.text.isEmpty ? 0.0 : double.parse(amountCont.text),
                            id: DateTime.now().toString(),
                            date: selectedDate
                          )
                        );
                      },
                    ),

                  ],
                ),
              ),
            );
  }
}