import 'package:flutter/foundation.dart';
class Transactions{
  final String id,title;
  final DateTime date;
  final double money;
  Transactions({@required this.id,@required this.title,@required this.date,@required this.money});
}