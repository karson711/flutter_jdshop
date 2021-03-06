import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import '../../providers/CartProvider.dart';
import '../../model/ProductContentModel.dart';

class CartNum extends StatefulWidget {
  Map _itemData;
  CartNum(this._itemData, {Key key}) : super(key: key);

  @override
  _CartNumState createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  Map _itemData;
  var cartProvider;

  //左侧按钮
  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        if (this._itemData['count'] > 1) {
          setState(() {
            this._itemData['count'] = this._itemData['count'] - 1;
          });
          this.cartProvider.itemCountChange();
        }
      },
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
      onTap: () {
        setState(() {
          this._itemData['count'] = this._itemData['count'] + 1;
        });
        this.cartProvider.itemCountChange();
      },
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
    int countNum =
        this._itemData['count'] == null ? 1 : this._itemData['count'];
    return Container(
      height: ScreenAdapter.height(45),
      width: ScreenAdapter.width(70),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
              right: BorderSide(width: 1, color: Colors.black12))),
      child: Text('$countNum'),
    );
  }

  @override
  Widget build(BuildContext context) {
    this._itemData = widget._itemData;
    this.cartProvider = Provider.of<CartProvider>(context);
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
