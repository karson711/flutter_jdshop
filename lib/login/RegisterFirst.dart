import 'package:flutter/material.dart';

import '../widget/JdText.dart';
import '../widget/JDBottimBtn.dart';
import '../services/ScreenAdapter.dart';
import '../services/JKToast.dart';
import 'package:dio/dio.dart';
import '../config/Config.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key key}) : super(key: key);

  _RegisterFirstPageState createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String tel = '';
  sendCode() async {
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(this.tel)) {
      var api = '${Config.domain}api/sendCode';
      var response = await Dio().post(api, data: {"tel": this.tel});
      if (response.data["success"]) {
        print(response); //演示期间服务器直接返回  给手机发送的验证码

        Navigator.pushNamed(context, '/registerSecond',
            arguments: {"tel": this.tel});
      } else {
        JKToast.sendMsg('${response.data["message"]}');
      }
    } else {
      JKToast.sendMsg('手机号格式不对');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
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
                this.tel = value;
              },
            ),
            SizedBox(height: 20),
            JDBottomBtn(
              text: '下一步',
              color: Colors.red,
              height: 74,
              callBack: this.sendCode,
            )
          ],
        ),
      ),
    );
  }
}
