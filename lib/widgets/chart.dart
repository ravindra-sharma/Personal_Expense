import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transaction.dart';
import 'package:personal_expense/widgets/chart_bar.dart';

class Chart extends StatelessWidget {

  List<Transaction> recentTrans;

  Chart(this.recentTrans);

  List<Map<String, Object>> get groupedTransactionValues{
    return List.generate(7, (index){

      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0;

      for(var i=0 ; i< recentTrans.length; i++){
        if(recentTrans[i].date.day == weekDay.day 
        && recentTrans[i].date.month == weekDay.month
        && recentTrans[i].date.year == weekDay.year){
          total+= recentTrans[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0,1),
        "amount": total
      };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionValues.fold(0.0, (sum, tx){
      return sum += tx['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0 ? 0.0 : (data['amount'] as double) /totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}