import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transcations;
  final Function deleteTrans;

  TransactionList(this.transcations, this.deleteTrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: transcations.isEmpty ? 
        Column(children: <Widget>[
          Text("There seems no data"),
          SizedBox(height: 20,),
          Container(
            height: 350,
            child: Image.asset(
            "assets/images/waiting.png",
            fit: BoxFit.cover,
        ),
          ) 
        ],)    
       : ListView.builder(
        itemCount: transcations.length,
        itemBuilder: (context, index){
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 6,
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text('\u20B9${transcations[index].amount.toStringAsFixed(0)}')
                    ),
                ),
                radius: 30,
              ),
              title: Text(transcations[index].title, style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              )),
              subtitle: Text(
                DateFormat.yMMMEd().format(transcations[index].date)
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_forever),
                color: Theme.of(context).errorColor,
                onPressed: ()=> deleteTrans(transcations[index].id) ,
              ),
            ),
          );
        },
      )
    );
  }
}