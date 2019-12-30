import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../services/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jdshop/config/Config.dart';
import '../../model/FocusModel.dart';
import '../../model/ProductModel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _focusData = [];
  List _hotProductList = [];
  List _bestProductList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getFocusData();
    this._getHotProductData();
    this._getBestProductData();
  }

  //获取轮播图数据
  void _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focuslist = FocusModel.fromJson(result.data);
    setState(() {
      this._focusData = focuslist.result;
    });
  }

  //获取猜你喜欢数据
  void _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);

    var hotProductlist = ProductModel.fromJson(result.data);
    setState(() {
      this._hotProductList = hotProductlist.result;
    });
  }

  //获取推荐商品数据
  void _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);

    var _bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      this._bestProductList = _bestProductList.result;
    });
  }

  //广告轮播
  Widget _swiperWidget() {
    if (this._focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = this._focusData[index].pic;
              //'\\'中第一个\是标识转义字符
              pic = Config.domain + pic.replaceAll('\\', '/');
              return new Image.network(
                '${pic}',
                fit: BoxFit.fill,
              );
            },
            itemCount: this._focusData.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(40),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenAdapter.width(10),
      ))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  //热门商品
  Widget _hotProductListWidget() {
    if (this._hotProductList.length > 0) {
      return Container(
        height: ScreenAdapter.height(234),
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (contxt, index) {
            String sPic = this._hotProductList[index].sPic;
            sPic = Config.domain + sPic.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  height: ScreenAdapter.height(140),
                  width: ScreenAdapter.height(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  child: Image.network(
                    '${sPic}',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(44),
                  child: Text('¥${this._hotProductList[index].price}',
                      style: TextStyle(color: Colors.red)),
                )
              ],
            );
          },
        ),
      );
    } else {
      return Text('');
    }
  }

  //推荐商品
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidthDP() -
            3 * ScreenAdapter.width(10) -
            4 * ScreenAdapter.width(1)) /
        2;

    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(10)),
      child: Wrap(
        runSpacing: ScreenAdapter.height(10),
        spacing: ScreenAdapter.width(10),
        children: this._bestProductList.map((value) {
          String sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');
          
          return Container(
            padding: EdgeInsets.all(ScreenAdapter.width(10)),
            width: itemWidth,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    width: ScreenAdapter.width(1))),
            child: Column(
              children: <Widget>[
                Container(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      '${sPic}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                  child: Text(
                    '${value.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '¥${value.price}',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '¥${value.oldPrice}',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: ScreenAdapter.height(20)),
        _titleWidget('猜你喜欢'),
        SizedBox(height: ScreenAdapter.height(20)),
        _hotProductListWidget(),
        _titleWidget('热门推荐'),
        _recProductListWidget(),
      ],
    );
  }
}
