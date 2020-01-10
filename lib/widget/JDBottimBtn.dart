import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class JDBottomBtn extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final Object callBack;

  JDBottomBtn(
      {Key key,
      this.text = '按钮',
      this.color = Colors.blue,
      this.height = 68,
      this.callBack = null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.callBack,
      child: Container(
        height: ScreenAdapter.height(this.height),
        width: double.infinity,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: this.color),
        child: Center(
          child: Text('${this.text}',style: TextStyle(
            color: Colors.white,
            fontSize: ScreenAdapter.size(32)
          ),),
        ),
      ),
    );
  }
}
