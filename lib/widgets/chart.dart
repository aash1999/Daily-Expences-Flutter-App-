import 'package:flutter/material.dart';
import '../model/transactions.dart';
import 'package:intl/intl.dart';
import './bar.dart';


class Chart extends StatelessWidget{
  List<Transactions> resentTransactionHistory;
  Chart(this.resentTransactionHistory);

  
  List<Map<String,Object>> get GroupedTransactionValue{
    return(
      List.generate(7,(index){
        var weekDay = DateTime.now().subtract(Duration(days:index));
        double totalSumPerDay=0.0;
        
        for(int i=0;i<resentTransactionHistory.length;i++){
          if(resentTransactionHistory[i].date.day==weekDay.day && 
          resentTransactionHistory[i].date.month==weekDay.month &&
          resentTransactionHistory[i].date.year==weekDay.year){
            totalSumPerDay+=resentTransactionHistory[i].money;
          

          }
        }
        return(
          {'day':DateFormat.E().format(weekDay).substring(0,1),'amount':totalSumPerDay}
        );
      })
    );
  }

  double get TotalSumMoney {
    return(GroupedTransactionValue.fold(0.0,(sum,item){
      return(sum+item['amount']);
    }));
  }
  
  @override
  Widget build(BuildContext context ){
    print(GroupedTransactionValue);
    return(Card(
      
      elevation:60,
      margin:EdgeInsets.all(20),
      child:Padding(
        padding:EdgeInsets.all(10),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:GroupedTransactionValue.reversed.map((txn){
          return(
            Flexible(
              fit:FlexFit.tight,
              child:Bar(amount:txn['amount'] ,label:txn['day'] ,percentage:TotalSumMoney !=0.0?(txn['amount'] as double)/TotalSumMoney:0.0)));
        }).toList(),
      )),


    ));
  }
}