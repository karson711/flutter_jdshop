import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:dio/dio.dart';
import '../services/ScreenAdapter.dart';
import '../model/ProductModel.dart';
import '../widget/LoadingWIdget.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;
  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //Scaffold key 侧边栏抽屉
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //用于分页
  ScrollController _scrollController = ScrollController();

  //分页
  int _page = 1;
  int _pageSize = 8;

  List _produceList = [];
  /*
  排序:价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  */
  String _sort = '';

  //解决重复请求的问题
  bool flag = true;

  //是否有数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    this._getProductList();

    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //_scrollController.position.pixels //获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent  //获取页面高度
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 30) {
        if (this._hasMore && this.flag) {
          this._getProductList();
        }
      }
    });
  }

  //获取商品列表数据
  void _getProductList() async {
    setState(() {
      this.flag = false;
    });

    var api =
        '${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    print(api);
    var result = await Dio().get(api);
    var productList = new ProductModel.fromJson(result.data);

    print(productList.result.length);
    if (productList.result.length < this._pageSize) {
      setState(() {
        this._produceList.addAll(productList.result);
        this._hasMore = false;
        this.flag = true;
      });
    } else {
      setState(() {
        this._produceList.addAll(productList.result);
        this._page++;
        this.flag = true;
      });
    }
  }

  //显示加载中的圈圈
  Widget _showMoreWidget(index) {
    if (this._hasMore) {
      return (index == this._produceList.length - 1)
          ? LoadingWidget()
          : Text('');
    } else {
      return (index == this._produceList.length - 1)
          ? Text('---我是有底线的---')
          : Text('');
    }
  }

  //商品列表
  Widget _productListWidget() {
    if (this._produceList.length > 0) {
      return Container(
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: this._produceList.length,
          itemBuilder: (context, index) {
            String pic = this._produceList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      height: ScreenAdapter.height(180),
                      width: ScreenAdapter.width(180),
                      child: Image.network('${pic}', fit: BoxFit.cover),
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
                              '${this._produceList[index].title}',
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
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text('4g'),
                                ),
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color:
                                          Color.fromRGBO(230, 230, 230, 0.9)),
                                  child: Text('126g'),
                                )
                              ],
                            ),
                            Text(
                              '￥${this._produceList[index].price}',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(height: 20),
                _showMoreWidget(index)
              ],
            );
          },
        ),
      );
    } else {
      return LoadingWidget();
    }
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
