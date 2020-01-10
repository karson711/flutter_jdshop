import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/JdText.dart';
import '../widget/JDBottimBtn.dart';
import '../config/Config.dart';
import '../services/JKToast.dart';
import '../services/EventBus.dart';
import 'package:dio/dio.dart';
import '../services/Storage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //监听登录页面销毁的事件
  dispose() {
    super.dispose();
    eventBus.fire(new UserEvent('登录成功...'));
  }

  String username = '';
  String password = '';
  doLogin() async {
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (!reg.hasMatch(this.username)) {
      JKToast.sendMsg('手机号格式不对');
    } else if (password.length < 6) {
      JKToast.sendMsg('密码不正确');
    } else {
      var api = '${Config.domain}api/doLogin';
      var response = await Dio().post(api,
          data: {"username": this.username, "password": this.password});
      if (response.data["success"]) {
        print(response.data);
        //保存用户信息
        Storage.setString('userInfo', json.encode(response.data["userinfo"]));

        Navigator.pop(context);
      } else {
        JKToast.sendMsg('${response.data["message"]}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // title: Text("登录页面"),
        actions: <Widget>[
          FlatButton(
            child: Text("客服"),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                height: ScreenAdapter.width(160),
                width: ScreenAdapter.width(160),
                // child: Image.asset('images/login.png'),
                child: Image.network(
                    'https://www.itying.com/images/flutter/list5.jpg',
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 30),
            JdText(
              text: "请输入用户名",
              onChanged: (value) {
                this.username = value;
              },
            ),
            SizedBox(height: 10),
            JdText(
              text: "请输入密码",
              password: true,
              onChanged: (value) {
                this.password = value;
              },
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('忘记密码'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/registerFirst');
                      },
                      child: Text('新用户注册'),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            JDBottomBtn(
              text: '登录',
              color: Colors.red,
              callBack: this.doLogin,
            )
          ],
        ),
      ),
    );
  }
}
