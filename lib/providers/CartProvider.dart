import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/CartServices.dart';
import '../services/Storage.dart';

class CartProvider with ChangeNotifier {
  List _cartList = []; //购物车列表
  bool _isCheckedAll = false; //全选
  double _allPrice = 0; //总价
  List get cartList => this._cartList;
  bool get isCheckedAll => this._isCheckedAll;
  double get allPrice => this._allPrice;

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
    this._isCheckedAll = this.isCheckAll();
    //计算总价
    this.computeAllPrice();
    notifyListeners();
  }

  updateCartList() {
    this.init();
  }

  itemCountChange() {
    
    Storage.setString("cartList", json.encode(this._cartList));

    //计算总价
    this.computeAllPrice();
    notifyListeners();
  }
  //全选、反选
  checkAll(val) {
    for (var i = 0; i < this._cartList.length; i++) {
      this._cartList[i]['checked'] = val;
    }
    this._isCheckedAll = val;
    //计算总价
    this.computeAllPrice();
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
    //计算总价
    this.computeAllPrice();
    
    notifyListeners();
  }
  
  //计算总价
  computeAllPrice() {
    double tempAllPrice = 0;
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]['checked'] == true) {
        tempAllPrice += this._cartList[i]['price'] * this._cartList[i]['count'];
      }
    }
    this._allPrice = tempAllPrice;
    notifyListeners();
  }

  //删除
  removeItem(){
    List tempList = [];
    for (var i = 0; i < this._cartList.length; i++) {
      if (this._cartList[i]['checked'] == false) {
        tempList.add(this._cartList[i]);
      }
    }
    this._cartList = tempList;
    Storage.setString("cartList", json.encode(this._cartList));
    //计算总价
    this.computeAllPrice();
    notifyListeners();
  }

}
