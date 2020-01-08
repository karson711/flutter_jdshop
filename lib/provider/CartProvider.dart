import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
  List _cartList = [];

  int get cartNum => this._cartList.length;
  List get cartList => this._cartList;

  addData(value){
    this._cartList.add(value);
    notifyListeners();
  }
   
  deleteData(value){
    this.cartList.remove(value);
    notifyListeners();
  }
}