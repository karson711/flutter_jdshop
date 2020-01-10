import 'package:flutter/material.dart';

import '../widget/JdText.dart';
import '../widget/JDBottimBtn.dart';
import '../services/ScreenAdapter.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第一步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50),
            JdText(
              text: "请输入手机号",
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: 20),
            JDBottomBtn(
              text: '下一步',
              color: Colors.red,
              height: 74,
              callBack: () {
                Navigator.pushNamed(context, '/registerSecond');
              },
            )
          ],
        ),
      ),
    );
  }
}
