import 'package:flutter/material.dart';
import './model/transactions.dart';
import './widgets/transactionList.dart';
import './widgets/enterTransaction.dart';
import './widgets/chart.dart';
void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return(MaterialApp(
      theme:ThemeData(
        appBarTheme:AppBarTheme(
          textTheme:ThemeData.light().textTheme.copyWith(
            title:TextStyle(
              fontFamily:'Quicksand',fontSize:20,fontWeight:FontWeight.bold
              )
              ),
        ),
        textTheme:ThemeData.light().textTheme.copyWith(
          title:TextStyle(
            fontFamily:'OpenSans',fontSize:20,fontWeight:FontWeight.bold
            )
            ),
        fontFamily:'Quicksand',
        primarySwatch:Colors.deepPurple,
      ),
      title:'Personal Expences',
      home:HomePage(), 
    ));
  }
}
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return(HomePageState());
  }
}


class HomePageState extends State<HomePage>{
    final titleController=TextEditingController();
    final moneyController=TextEditingController();
    final List<Transactions> transactionHistory=[
    
    
  ];
  void _SubmitTransactions(var daTe){
   var titleIs = titleController.text;
   var moneyIs = moneyController.text;
   if (titleIs.isEmpty || double.parse(moneyIs)<=0 || daTe == null){
     return ;
   }
   setState(() {
     _addNewTransaction(titleIs,double.parse(moneyIs),daTe);
     Navigator.of(context).pop();
   });
    
  }

  void _DeleteTransaction(id){
    transactionHistory.removeWhere((txn){
      return(txn.id == id);
    });
    setState(() {
      transactionHistory;
    });

  }

  void _startNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      context:ctx,
      builder:(_){
        return(EnterTransaction(_SubmitTransactions,titleController,moneyController));

    });
  }
   void _addNewTransaction(tnxTitle,tnxMoney,daTe){
    final txn = Transactions(
    date:daTe,
    title:tnxTitle ,
    money:tnxMoney ,
    id:DateTime.now().toString() 
    );
    
     transactionHistory.add(txn);  
    }
  List<Transactions> get resentTransactionHistory{
    return(transactionHistory.where((txn){
      return(txn.date.isAfter(DateTime.now().subtract(Duration(days:7))));
    }).toList());
  }
  @override
  Widget build(BuildContext context){
    return(Scaffold(
      appBar : AppBar(

        actions:[
          IconButton(
            icon:Icon(Icons.add),
            onPressed:(){_startNewTransaction(context);},
          ),
        ],
        title: Text('Personal Expences',style:TextStyle(fontFamily:'OpenSans')),
      ),
      body :SingleChildScrollView(child:Column(
        mainAxisAlignment:MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.center,
        children:[
          Chart(resentTransactionHistory),
          Column(
          children:[

            Container(
      height:500,
      child:TransactionList(transactionHistory,_DeleteTransaction),
      )],
      ),
     ],
      )
      ),
      floatingActionButton:FloatingActionButton(
        child:Icon(Icons.add), 
        onPressed:(){_startNewTransaction(context);}, 
      ),
      floatingActionButtonLocation : FloatingActionButtonLocation.centerFloat,
      
      
    )
    );
  }

}