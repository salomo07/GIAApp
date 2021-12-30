import 'package:flutter/cupertino.dart';

class Categories with ChangeNotifier{
  String strJson='';
  String get data => this.strJson;
  set data (String newData){
    this.strJson=newData;
    notifyListeners();
  }
}