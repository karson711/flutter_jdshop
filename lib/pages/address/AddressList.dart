import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../config/Config.dart';
import '../../services/UserServices.dart';
import 'package:dio/dio.dart';
import '../../services/EventBus.dart';
import '../../services/SignServices.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key key}) : super(key: key);

  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];

  @override
  void initState() {
    super.initState();
    this._getAddressList();

    //监听增加收货地址的广播
    eventBus.on<AddressEvent>().listen((event) {
      print(event.str);
      this._getAddressList();
    });
  }

  //监听页面销毁的事件
  dispose() {
    super.dispose();
    eventBus.fire(new CheckOutEvent('改收货地址成功...'));
  }

  _getAddressList() async {
    //请求接口
    List userinfo = await UserServices.getUserInfo();

    var tempJson = {"uid": userinfo[0]['_id'], "salt": userinfo[0]["salt"]};

    var sign = SignServices.getSign(tempJson);

    var api =
        '${Config.domain}api/addressList?uid=${userinfo[0]['_id']}&sign=$sign';

    var response = await Dio().get(api);
    // print(response.data["result"]);

    setState(() {
      this.addressList = response.data["result"];
    });
  }

  //修改默认收货地址
  _changeDefaultAddress(id) async {
    List userinfo = await UserServices.getUserInfo();

    var tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]["salt"]
    };

    var sign = SignServices.getSign(tempJson);

    var api = '${Config.domain}api/changeDefaultAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]['_id'], "id": id, "sign": sign});
    print(response);
    Navigator.pop(context);
  }

  //删除收货地址

  _delAddress(id) async {
    List userinfo = await UserServices.getUserInfo();
    var tempJson = {
      "uid": userinfo[0]["_id"],
      "id": id,
      "salt": userinfo[0]["salt"]
    };

    var sign = SignServices.getSign(tempJson);

    var api = '${Config.domain}api/deleteAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]["_id"], "id": id, "sign": sign});
    this._getAddressList(); //删除收货地址完成后重新获取列表
  }

  //弹出框
  _showDelAlertDialog(id) async {
    var result = await showDialog(
        barrierDismissible: false, //表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示信息!"),
            content: Text("您确定要删除吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () async {
                  //执行删除操作
                  this._delAddress(id);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("收货地址列表"),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: this.addressList.length,
                itemBuilder: (context, index) {
                  if (this.addressList[index]["default_address"] == 1) {
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        ListTile(
                          leading: Icon(Icons.check, color: Colors.red),
                          title: InkWell(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                    SizedBox(height: 10),
                                    Text(
                                        "${this.addressList[index]["address"]}"),
                                  ]),
                              onTap: () {
                                this._changeDefaultAddress(
                                    this.addressList[index]["_id"]);
                              },
                              onLongPress: () {
                                this._showDelAlertDialog(
                                    this.addressList[index]["_id"]);
                              }),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              print('点击编辑按钮');
                              Navigator.pushNamed(context, '/addressEdit',
                                  arguments: {
                                    "id": this.addressList[index]["_id"],
                                    "name": this.addressList[index]["name"],
                                    "phone": this.addressList[index]["phone"],
                                    "address": this.addressList[index]
                                        ["address"],
                                  });
                            },
                          ),
                        ),
                        Divider(height: 20),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        ListTile(
                          title: InkWell(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                    SizedBox(height: 10),
                                    Text(
                                        "${this.addressList[index]["address"]}"),
                                  ]),
                              onTap: () {
                                this._changeDefaultAddress(
                                    this.addressList[index]["_id"]);
                              },
                              onLongPress: () {
                                this._showDelAlertDialog(
                                    this.addressList[index]["_id"]);
                              }),
                          trailing: IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              print('点击编辑按钮');
                              Navigator.pushNamed(context, '/addressEdit',
                                  arguments: {
                                    "id": this.addressList[index]["_id"],
                                    "name": this.addressList[index]["name"],
                                    "phone": this.addressList[index]["phone"],
                                    "address": this.addressList[index]
                                        ["address"],
                                  });
                            },
                          ),
                        ),
                        Divider(height: 20),
                      ],
                    );
                  }
                },
              ),
              Positioned(
                bottom: 0,
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(88),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: ScreenAdapter.width(750),
                  height: ScreenAdapter.height(88),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black26))),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.white),
                        Text("增加收货地址", style: TextStyle(color: Colors.white))
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/addressAdd');
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
