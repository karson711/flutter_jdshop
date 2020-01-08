import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../provider/Counter.dart';
import '../../provider/CartProvider.dart';
import '../cart/CartItem.dart';
import '../cart/CartNum.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var counterProvider = Provider.of<Counter>(context);
    var cartProvicer = Provider.of<CartProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counterProvider.increment();
          cartProvicer.addData('hello${cartProvicer.cartNum}');
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Column(
        children: <Widget>[
          Center(
              child: Text(
            '统计数量：${counterProvider.count}',
            style: TextStyle(fontSize: 20),
          )),
          Divider(),
          CartItem(),
          Divider(height: 40),
          CartNum()
        ],
      ),
    );
  }
}
