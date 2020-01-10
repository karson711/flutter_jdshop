import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JDBottimBtn.dart';
import '../services/ScreenAdapter.dart';

class RegisterThirdPage extends StatefulWidget {
  RegisterThirdPage({Key key}) : super(key: key);

  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户注册-第三步"),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 50),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: 10),
            JdText(
              text: "请输入确认密码",
              password: true,
              onChanged: (value) {
                print(value);
              },
            ),
            SizedBox(height: 20),
            JDBottomBtn(
              text: '登录',
              color: Colors.red,
              height: 74,
              callBack: () {
                
              },
            )
          ],
        ),
      ),
    );
  }
}
