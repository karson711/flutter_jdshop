import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final Icon icon;
  final String str;
  EmptyDataWidget({Key key,this.str='',this.icon= null}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          this.icon,
          Text('${this.str}')
        ],
      ),
    );
  }
}