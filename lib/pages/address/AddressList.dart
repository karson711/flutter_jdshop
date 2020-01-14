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
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                SizedBox(height: 10),
                                Text("${this.addressList[index]["address"]}"),
                              ]),
                          trailing: Icon(Icons.edit, color: Colors.blue),
                        ),
                        Divider(height: 20),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        ListTile(
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${this.addressList[index]["name"]}  ${this.addressList[index]["phone"]}"),
                                SizedBox(height: 10),
                                Text("${this.addressList[index]["address"]}"),
                              ]),
                          trailing: Icon(Icons.edit, color: Colors.blue),
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
