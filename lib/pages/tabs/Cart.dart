import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';
import '../cart/CartItem.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var cartProvicer = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[CartItem(), CartItem(), CartItem()],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdapter.fulWidth(),
            height: ScreenAdapter.height(80),
            child: Container(
              width: ScreenAdapter.fulWidth(),
              height: ScreenAdapter.height(80),
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.black12)),
                  color: Colors.white),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: ScreenAdapter.width(60),
                          child: Checkbox(
                            value: true,
                            onChanged: (val) {},
                            activeColor: Colors.pink,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text('全选')
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: ScreenAdapter.height(80),
                      width: ScreenAdapter.width(200),
                      child: RaisedButton(
                        child:
                            Text('结算', style: TextStyle(color: Colors.white)),
                        color: Colors.red,
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
