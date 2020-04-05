import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{
  final List transactionHistory;
  Function deleteTransaction;
  TransactionList(this.transactionHistory,this.deleteTransaction);
  @override
  Widget build(BuildContext context){
    return(transactionHistory.isEmpty? Column(
      children:[
        Text(
          "Transactions Is Empty",
          style:Theme.of(context).textTheme.title,
          ),
          SizedBox(height:10),
        Container(
          height:450,
          child:Image.asset('images/waiting.png',fit:BoxFit.cover)),
        ]
        )
    :ListView.builder(
      //'\u{20B9}${transactionHistory[transactionHistory.length-1-index].money.toStringAsFixed(2)}'
      //transactionHistory[transactionHistory.length-1-index].title,
      //DateFormat.yMd().format(transactionHistory[transactionHistory.length-1-index].date
            itemBuilder:(context,index){
              return(Card(
                child:ListTile(
                leading:CircleAvatar(
                  radius:30,
                  child:Padding(
                    padding:EdgeInsets.all(5),
                    child:FittedBox(
                      child:Text('\u{20B9}${transactionHistory[transactionHistory.length-1-index].money.toStringAsFixed(2)}')))),
                title:Text(transactionHistory[transactionHistory.length-1-index].title),
                subtitle:Text(DateFormat.yMd().format(transactionHistory[transactionHistory.length-1-index].date )),
                trailing: IconButton(
                  icon:Icon(Icons.delete),
                  onPressed:(){deleteTransaction(transactionHistory[transactionHistory.length-1-index].id);},
              ))));
                  
            },
            itemCount:transactionHistory.length,
            //crossAxisAlignment:CrossAxisAlignment.center,
            
          ));
  }
}