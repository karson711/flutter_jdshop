import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../provider/CartProvider.dart';

class CartNum extends StatefulWidget {
  CartNum({Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  //左侧按钮
  Widget _leftBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenAdapter.height(45),
        width: ScreenAdapter.width(45),
        alignment: Alignment.center,
        child: Text('-'),
      ),
    );
  }
  //右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenAdapter.height(45),
        width: ScreenAdapter.width(45),
        alignment: Alignment.center,
        child: Text('+'),
      ),
    );
  }
  //中间文字
  Widget _centerText() {
    return Container(
      height: ScreenAdapter.height(45),
      width: ScreenAdapter.width(70),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
              right: BorderSide(width: 1, color: Colors.black12))),
      child: Text('2'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    ScreenAdapter.init(context);

    return Container(
      width: ScreenAdapter.width(164),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          this._leftBtn(),
          this._centerText(),
          this._rightBtn()
        ],
      ),
    );
  }
}
