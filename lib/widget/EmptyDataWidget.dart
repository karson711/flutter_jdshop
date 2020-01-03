import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Icon(Icons.hourglass_empty),
          Text('没有您要浏览的数据')
        ],
      ),
    );
  }
}