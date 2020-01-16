import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/tabs/Tabs.dart';
import '../pages/ProductList.dart';
import '../pages/SearchPage.dart';
import '../pages/productDetail/ProductDetail.dart';

import '../login/Login.dart';
import '../login/RegisterFirst.dart';
import '../login/RegisterSecond.dart';
import '../login/RegisterThird.dart';

import '../pages/productDetail/CheckOut.dart';
import '../pages/address/AddressAdd.dart';
import '../pages/address/AddressEdit.dart';
import '../pages/address/AddressList.dart';
import '../pages/productDetail/Pay.dart';

import '../pages/order/Order.dart';
import '../pages/order/OrderInfo.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/login': (context) => LoginPage(),
  '/registerFirst': (context) => RegisterFirstPage(),
  '/registerSecond': (context,{arguments}) => RegisterSecondPage(arguments:arguments),
  '/registerThird': (context,{arguments}) => RegisterThirdPage(arguments:arguments),
  '/productList': (context,{arguments}) => ProductListPage(arguments:arguments),
  '/search': (context) => SearchPage(),
  '/productDetail': (context,{arguments}) => ProductDetailPage(arguments:arguments),
  '/checkOut': (context) => CheckOutPage(),
  '/addressAdd': (context) => AddressAddPage(),
  '/addressEdit': (context,{arguments}) => AddressEditPage(arguments:arguments),
  '/addressList': (context) => AddressListPage(),
  '/pay': (context) => PayPage(),
  '/order': (context) => OrderPage(),
  '/orderinfo': (context) => OrderInfoPage(),
};

//固定写法
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};