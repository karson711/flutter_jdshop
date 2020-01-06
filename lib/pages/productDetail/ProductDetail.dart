import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'ProductDetailFrist.dart';
import 'ProductDetailSecond.dart';
import 'ProductDetailThird.dart';

class ProductDetailPage extends StatefulWidget {
  Map arguments;
  ProductDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.arguments["id"]);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: ScreenAdapter.width(15)),
                width: ScreenAdapter.width(400),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                      child: Text('商品'),
                    ),
                    Tab(
                      child: Text('详情'),
                    ),
                    Tab(
                      child: Text('评价'),
                    )
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                        ScreenAdapter.width(600), 80, 10, 0),
                    items: [
                      PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.home),
                            SizedBox(width: ScreenAdapter.width(5)),
                            Text('首页')
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.search),
                            SizedBox(width: ScreenAdapter.width(5)),
                            Text('搜索')
                          ],
                        ),
                      )
                    ]
                );
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            TabBarView(
              children: <Widget>[
                ProductDetailFristPage(),
                ProductDetailSecondPage(),
                ProductDetailThirdPage()
              ],
            ),
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(80),
              bottom: 0,
              child: Container(
                color: Colors.red,
                child: Text('底部栏'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
