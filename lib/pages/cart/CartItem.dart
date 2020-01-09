import 'package:flutter/material.dart';
import 'package:flutter_jdshop/providers/CartProvider.dart';
import 'package:provider/provider.dart';
import '../cart/CartNum.dart';
import '../../services/ScreenAdapter.dart';

class CartItem extends StatefulWidget {
  Map _itemData;

  CartItem(this._itemData, {Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map _itemData;

  @override
  Widget build(BuildContext context) {
   
   this._itemData = widget._itemData;

    ScreenAdapter.init(context);
    var cartProvider = Provider.of<CartProvider>(context);


    return Container(
      padding: EdgeInsets.all(5),
      height: ScreenAdapter.height(220),
      width: ScreenAdapter.fulWidth(),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: this._itemData['checked'],
              activeColor: Colors.pink,
              onChanged: (val) {
                this._itemData['checked'] = !this._itemData['checked'];
                cartProvider.itemChange();
              },
            ),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network('${this._itemData['pic']}', fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${this._itemData['title']}', maxLines: 2),
                  Text('${this._itemData['selectedAttr']}'),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '¥${this._itemData['price']}',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: CartNum(this._itemData))
                    ],
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
