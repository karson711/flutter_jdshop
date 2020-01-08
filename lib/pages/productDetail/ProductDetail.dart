import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'ProductDetailFrist.dart';
import 'ProductDetailSecond.dart';
import 'ProductDetailThird.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JDBottimBtn.dart';
import '../../config/Config.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../model/ProductContentModel.dart';
import '../../widget/LoadingWidget.dart';


class ProductDetailPage extends StatefulWidget {
  Map arguments;
  ProductDetailPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  
  List _productContentList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getProductDetailData();
  }

  void _getProductDetailData() async{
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';
    print(api);
    var result = await Dio().get(api);
    print(result);
    var productContent = new ProductContentModel.fromJson(result.data);
    print(productContent.result.pic);
    List arr = [];
    arr.add(productContent.result);
    setState(() {
      this._productContentList = arr;
      print(this._productContentList);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

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
                    ]);
              },
            )
          ],
        ),
        body: this._productContentList.length>0?Stack(
          children: <Widget>[
            TabBarView(
              children: <Widget>[
                ProductDetailFristPage(this._productContentList),
                ProductDetailSecondPage(this._productContentList),
                ProductDetailThirdPage()
              ],
            ),
            Positioned(
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(88),
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black12, width: 1)),
                    color: Colors.white),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                      width: ScreenAdapter.width(200),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          Text('购物车')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: JDBottomBtn(
                        color: Color.fromRGBO(253, 1, 0, 0.9),
                        text: '加入购物车',
                        callBack: () {
                          print('加入购物车');
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: JDBottomBtn(
                        color: Color.fromRGBO(255, 165, 0, 0.9),
                        text: '立即购买',
                        callBack: () {
                          print('立即购买');
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ):LoadingWidget(),
      ),
    );
  }
}