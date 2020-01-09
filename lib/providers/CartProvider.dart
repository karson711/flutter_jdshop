import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import '../services/Storage.dart';

class CartProvider with ChangeNotifier {
  List _cartList = []; //状态
  bool _isCheckedAll = false;
  List get cartList => this._cartList;
  bool get isCheckedAll => this._isCheckedAll;

  CartProvider() {
    this.init();
  }

  init() async {
    try {
      List cartListData = json.decode(await Storage.getString('cartList'));
      this._cartList = cartListData;
    } catch (e) {
      this._cartList = [];
    }
    this._isCheckedAll=this.isCheckAll();
    notifyListeners();
  }

  updateCartList() {
    this.init();
  }

  itemCountChange() {
    Storage.setString("cartList", json.encode(this._cartList));
    notifyListeners();
  }

  checkAll(val) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]['checked'] = val;
    }
    this._isCheckedAll = val;
    Storage.setString("cartList", json.encode(this._cartList));
    notifyListeners();
  }

  //判断是否全选
  bool isCheckAll() {
    if (this._cartList.length > 0) {
      for (var i = 0; i < this._cartList.length; i++) {
        if (this._cartList[i]['checked'] == false) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  itemChange() {
    this._isCheckedAll = this.isCheckAll();
    Storage.setString("cartList", json.encode(this._cartList));
    notifyListeners();
  }
}
