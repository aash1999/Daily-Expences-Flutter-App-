import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EnterTransaction extends StatefulWidget {
  Function SubmitTransactions;
  var titleController,moneyController;
  EnterTransaction(this.SubmitTransactions,this.titleController,this.moneyController);
  @override
  _EnterTransactionState createState() => _EnterTransactionState(SubmitTransactions,titleController,moneyController);
}

class _EnterTransactionState extends State<EnterTransaction> {
  Function SubmitTransactions;
  var titleController,moneyController;
  DateTime datePicked;
  _EnterTransactionState(this.SubmitTransactions,this.titleController,this.moneyController);
  void DateEntered(BuildContext ctx){
    showDatePicker(
      context:ctx,
      initialDate:DateTime.now(),
      lastDate:DateTime.now(),
      firstDate:DateTime(DateTime.now().year),
      ).then((pickedDate){
        if(pickedDate == null){
          return null;

        }else{
          datePicked=pickedDate;
          setState((){
            datePicked;
          });
        }
      });
  }
  @override
  Widget build(BuildContext context) {
    return(GestureDetector(
          onTap:(){},
          behavior: HitTestBehavior.opaque,
          child:Container(
            padding:EdgeInsets.all(3),
            child:Column(
            crossAxisAlignment:CrossAxisAlignment.end,
            children:[
              Card(
                child:TextField(
                  keyboardType:TextInputType.text,
                  onSubmitted:(_)=>(){SubmitTransactions(datePicked);} ,
                  controller:titleController,
                  decoration: InputDecoration(
                    labelText:'Title'
                  ),
                ),
                ),
              Card(
                child:TextField(
                  keyboardType:TextInputType.number,
                  onSubmitted:(_)=>(){SubmitTransactions(datePicked);},
                  controller:moneyController,
                  decoration: InputDecoration(
                    labelText:'Money'
                  ),
                ),
                ), 
              Container(
                height:60,
                child:Row(
                children:[
                  Text(datePicked == null?'No Date Entered':DateFormat.yMd().format(datePicked)),
                  FlatButton(child:Text(
                    'Select Date',
                    style:TextStyle(
                      color:Colors.deepOrange,
                      fontWeight: FontWeight.bold
                       )
                       ),
                       onPressed:(){DateEntered(context);}),
                ]
              )),

              RaisedButton(
              //  textColor: Colors.deepPurpleAccent,
                child:Text("Add Transaction",
                style:TextStyle(fontWeight: FontWeight.bold)),
                onPressed:(){SubmitTransactions(datePicked);},
              ), 
            ],
          ),
          )));
  }
}