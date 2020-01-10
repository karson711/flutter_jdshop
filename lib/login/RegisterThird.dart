import 'dart:convert';

import 'package:flutter/material.dart';
import '../widget/JdText.dart';
import '../widget/JDBottimBtn.dart';
import '../services/ScreenAdapter.dart';
import '../config/Config.dart';
import '../services/JKToast.dart';
import '../pages/tabs/Tabs.dart';
import '../services/Storage.dart';
import 'package:dio/dio.dart';

class RegisterThirdPage extends StatefulWidget {
  Map arguments;
  RegisterThirdPage({Key key, this.arguments}) : super(key: key);

  _RegisterThirdPageState createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String tel;
  String code;
  String password = '';
  String rpassword = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.arguments);
    this.tel = widget.arguments["tel"];
    this.code = widget.arguments["code"];

  }

  //注册
  doRegister() async {
    if (password.length < 6) {
      JKToast.sendMsg('密码长度不能小于6位');
    } else if (rpassword != password) {
      JKToast.sendMsg('密码和确认密码不一致');
    } else {
      var api = '${Config.domain}api/register';
      var response = await Dio().post(api, data: {
        "tel": this.tel,
        "code": this.code,
        "password": this.password
      });
      if (response.data["success"]) {
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));

        //返回到根
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new Tabs(index: 3)),
            (route) => route == null);
      } else {
        JKToast.sendMsg('${response.data["message"]}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
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
                this.password = value;
              },
            ),
            SizedBox(height: 10),
            JdText(
              text: "请输入确认密码",
              password: true,
              onChanged: (value) {
                this.rpassword = value;
              },
            ),
            SizedBox(height: 20),
            JDBottomBtn(
              text: '登录',
              color: Colors.red,
              height: 74,
              callBack: this.doRegister,
            )
          ],
        ),
      ),
    );
  }
}
