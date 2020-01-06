import 'package:flutter/material.dart';

class ProductDetailThirdPage extends StatefulWidget {
  ProductDetailThirdPage({Key key}) : super(key: key);

  @override
  _ProductDetailThirdPageState createState() => _ProductDetailThirdPageState();
}

class _ProductDetailThirdPageState extends State<ProductDetailThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('第$index行'),
          );
        },
      ),
    );
  }
}