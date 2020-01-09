import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../providers/CartProvider.dart';
import '../cart/CartItem.dart';
import '../../widget/EmptyDataWidget.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvicer = Provider.of<CartProvider>(context);
    print(cartProvicer.cartList);
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                this._isEdit = !this._isEdit;
              });
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          cartProvicer.cartList.length > 0
              ? ListView(
                  children: <Widget>[
                    Column(
                      children: cartProvicer.cartList.map((value) {
                        return CartItem(value);
                      }).toList(),
                    ),
                    SizedBox(height: ScreenAdapter.height(100))
                  ],
                )
              : EmptyDataWidget(icon: Icon(Icons.shopping_cart),str: '购物车空空如也...'),
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
                            value: cartProvicer.isCheckAll(),
                            onChanged: (val) {
                              //实现全选或者反选
                              cartProvicer.checkAll(val);
                            },
                            activeColor: Colors.pink,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text('全选'),
                        SizedBox(width: 20),
                        this._isEdit ? Text('') : Text('总计:'),
                        this._isEdit
                            ? Text('')
                            : Text('¥${cartProvicer.allPrice}',
                                style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: ScreenAdapter.height(80),
                      width: ScreenAdapter.width(200),
                      child: RaisedButton(
                        child: Text(this._isEdit ? '删除' : '结算',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.red,
                        onPressed: () {
                          if (this._isEdit) {
                            //删除
                            cartProvicer.removeItem();
                          } else {
                            //结算

                          }
                        },
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
