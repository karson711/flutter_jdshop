import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{
  List _cartList = [];

  int get cartNum => this._cartList.length;
  List get cartList => this._cartList;


}