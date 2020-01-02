import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:dio/dio.dart';
import '../services/ScreenAdapter.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget _productListWidget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: ScreenAdapter.height(180),
                    width: ScreenAdapter.width(180),
                    child: Image.network(
                        'https://www.itying.com/images/flutter/list2.jpg',
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: ScreenAdapter.height(180),
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: ScreenAdapter.height(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Color.fromRGBO(230, 230, 230, 0.9)),
                                child: Text('4g'),
                              ),
                              Container(
                                height: ScreenAdapter.height(36),
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Color.fromRGBO(230, 230, 230, 0.9)),
                                child: Text('126g'),
                              )
                            ],
                          ),
                          Text(
                            '￥990',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Divider(height: 20)
            ],
          );
        },
      ),
    );
  }

  Widget _subHeaderWidget() {
    return Positioned(
      top: 0,
      height: ScreenAdapter.height(80),
      width: ScreenAdapter.width(750),
      child: Container(
        height: ScreenAdapter.height(80),
        width: ScreenAdapter.width(750),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    '综合',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    '销量',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {},
                child: Container(
                  child: Text(
                    '价格',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  print('筛选');
                  _scaffoldKey.currentState.openEndDrawer();
                },
                child: Container(
                  child: Text(
                    '筛选',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('商品列表'),
        actions: <Widget>[Text('')],
      ),
      endDrawer: Drawer(
        child: Container(
          child: Text('筛选功能'),
        ),
      ),
      body: Stack(
        children: <Widget>[this._productListWidget(), this._subHeaderWidget()],
      ),
    );
  }
}
