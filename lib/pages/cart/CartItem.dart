import 'package:flutter/material.dart';
import 'package:flutter_jdshop/providers/CartProvider.dart';
import 'package:provider/provider.dart';
import '../cart/CartNum.dart';
import '../../services/ScreenAdapter.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var cartProvider = Provider.of<CartProvider>(context);

    return Container(
      padding: EdgeInsets.all(5),
      height: ScreenAdapter.height(180),
      width: ScreenAdapter.fulWidth(),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: true,
              activeColor: Colors.pink,
              onChanged: (val) {},
            ),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network(
                'https://www.itying.com/images/flutter/list2.jpg',
                fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('菲特旋转盖轻量杯不锈钢保温杯学生杯商务杯情侣杯保冷杯子便携水杯LHC4131WB(450Ml)白蓝',
                      maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('¥12',style: TextStyle(color: Colors.red),),
                      ),
                      Align(alignment: Alignment.centerRight, child: CartNum(null))
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
