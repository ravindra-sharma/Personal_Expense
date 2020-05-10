import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Manager",
      home: MyApp(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
          button: TextStyle(
            color: Colors.white
          )
        )
      ),
    );
  }

}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void addNewTransaction(Transaction tx){
     if(tx.title == null || tx.amount <= 0 || tx.date== null  ){
       Toast.show(
         "Please Fill All details!", 
         context,
         duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM
         );
       return;
     }
    this.setState((){
      transcations.add(tx);
    });
    Navigator.of(context).pop();
  }

  final List<Transaction> transcations  = [
  ];
  
  void startAddNewTrans(BuildContext ctx){
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx){
        return NewTransaction(addNewTransaction);
      } 
    );
  }

  void deleteTrans(String id){
    setState(() {
      transcations.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  List<Transaction> get _recentTrans{
    return transcations.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Manager"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startAddNewTrans(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: () => startAddNewTrans(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
              child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Chart(_recentTrans),
              TransactionList(transcations, deleteTrans)
            ],
          ),
        ),
      ),
    );
  }
}
