import 'package:flutter/material.dart';

class ProductDetailFristPage extends StatefulWidget {
  ProductDetailFristPage({Key key}) : super(key: key);

  @override
  _ProductDetailFristPageState createState() => _ProductDetailFristPageState();
}

class _ProductDetailFristPageState extends State<ProductDetailFristPage> {
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
