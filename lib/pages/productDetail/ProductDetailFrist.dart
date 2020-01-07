import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/ProductContentModel.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JDBottimBtn.dart';

class ProductDetailFristPage extends StatefulWidget {
  final List _productContentList;

  ProductDetailFristPage(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductDetailFristPageState createState() => _ProductDetailFristPageState();
}

class _ProductDetailFristPageState extends State<ProductDetailFristPage> {
  ProductContentItem _productContent;

  List _attr = [];

  @override
  void initState() {
    super.initState();

    this._productContent = widget._productContentList[0];
    this._attr = this._productContent.attr;
    print('----------------');
    print(this._attr.length);
    print('----------------');
  }

  List<Widget> _getAttrItemWidget(attrItem) {

    List<Widget> attrItemList = [];
    attrItem.list.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: Chip(
          label: Text('${item}'),
          padding: EdgeInsets.all(10),
        ),
      ));
    });
    return attrItemList;
  }

  List<Widget> _getAttrWidget() {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(32)),
              child: Text(
                '${attrItem.cate}:',
                style: TextStyle(
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: ScreenAdapter.width(590),
            child: Wrap(
              children: this._getAttrItemWidget(attrItem),
            ),
          )
        ],
      ));
    });
    return attrList;
  }

  void _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {

          return GestureDetector(
            onTap: () {
              return false;
            },
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(20)),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: this._getAttrWidget(),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  height: ScreenAdapter.height(90),
                  width: ScreenAdapter.width(750),
                  child: Row(
                    children: <Widget>[
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
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    String pic = this._productContent.pic;
    pic = Config.domain + pic.replaceAll('\\', '/');

    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: ListView(
        children: <Widget>[
          //图片
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.network('${pic}', fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.title}',
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdapter.size(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.subTitle}',
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black54, fontSize: ScreenAdapter.size(28)),
            ),
          ),
          //价格
          Container(
            height: ScreenAdapter.height(100),
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text('特价: '),
                      Text('¥${this._productContent.price}',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.size(46)))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('原价: '),
                      Text(
                        '¥${this._productContent.oldPrice}',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: ScreenAdapter.size(36),
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          InkWell(
            onTap: () {
              print(this._productContent.attr);
              this._attrBottomSheet();
            },
            child: Container(
              height: ScreenAdapter.height(80),
              child: Row(
                children: <Widget>[
                  Text('已选: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('115，黑色，XL，1件')
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text('运费: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('免运费')
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
