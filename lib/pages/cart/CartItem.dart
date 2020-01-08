import 'package:flutter/material.dart';
import 'package:flutter_jdshop/provider/CartProvider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.cartList.length>0?Column(
      children: cartProvider.cartList.map((value) {
        return ListTile(
          title: Text('${value}'),
          trailing: InkWell(
            onTap: () {
              cartProvider.deleteData(value);
            },
            child: Icon(Icons.delete),
          ),
        );
      }).toList(),
    ):Text('');
  }
}
