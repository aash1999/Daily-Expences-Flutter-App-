import 'package:flutter/material.dart';

class Bar extends StatelessWidget{
  String label;
  double percentage,amount;
  Bar({this.label,this.percentage,this.amount});
  @override
  Widget build(BuildContext context){
    return(Container(
      child:Column(
        children:[
          Container(
            height:20,
            child:FittedBox(
            child:Text('\u{20B9}${amount}'))),
        SizedBox(height:4),
        Container(
          height:60,
          width:10,
          child:Stack(
            children:[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey,width: 10
                  ),
                  color:Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                  ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child:Container(
                  decoration:BoxDecoration(
                    
                    color:Colors.blue,
                    borderRadius: BorderRadius.circular(20),

                  ) 
                  ,)
              ),

            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label),]
      ),
    ));
  }
}