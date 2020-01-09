import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:flutter_jdshop/model/ProductContentModel.dart';

import '../../services/ScreenAdapter.dart';
import '../../widget/JDBottimBtn.dart';
import '../../services/EventBus.dart';
import '../../services/CartServices.dart';
import 'ProductNum.dart';
import '../../providers/CartProvider.dart';
import 'package:provider/provider.dart';
import '../../services/JKToast.dart';

class ProductDetailFristPage extends StatefulWidget {
  final List _productContentList;

  ProductDetailFristPage(this._productContentList, {Key key}) : super(key: key);

  @override
  _ProductDetailFristPageState createState() => _ProductDetailFristPageState();
}

class _ProductDetailFristPageState extends State<ProductDetailFristPage>
    with AutomaticKeepAliveClientMixin {
  ProductContentItem _productContent;

  List _attr = [];
  String _selectValue;
  bool get wantKeepAlive => true;
  var actionEvent;
  var cartProvider;

  @override
  void initState() {
    super.initState();

    this._productContent = widget._productContentList[0];
    this._attr = this._productContent.attr;

    this._initAttr();

    //监听广播
    //监听所有广播
    // eventBus.on().listen((event) {
    //   print(event);
    //   this._attrBottomSheet();
    // });

    this.actionEvent = eventBus.on<ProductDetailEvent>().listen((str) {
      print(str);
      this._attrBottomSheet();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.actionEvent.cancel(); //取消事件监听
  }

  //初始化Attr 格式化数据
  void _initAttr() {
    for (var i = 0; i < this._attr.length; i++) {
      for (var j = 0; j < this._attr[i].list.length; j++) {
        if (j == 0) {
          this
              ._attr[i]
              .attrList
              .add({"title": this._attr[i].list[j], "checked": true});
        } else {
          this
              ._attr[i]
              .attrList
              .add({"title": this._attr[i].list[j], "checked": false});
        }
      }
    }

    this._getSelectAttrValue();
  }

  //改变属性值
  void _changeAttr(title, cate, setBottomState) {
    var attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      this._attr = attr;
    });
    this._getSelectAttrValue();
  }

  void _getSelectAttrValue() {
    List tempArr = [];
    for (var i = 0; i < this._attr.length; i++) {
      for (var j = 0; j < this._attr[i].attrList.length; j++) {
        if (this._attr[i].attrList[j]['checked'] == true) {
          tempArr.add(this._attr[i].attrList[j]['title']);
        }
      }
    }

    setState(() {
      this._selectValue = tempArr.join(',');
      this._productContent.selectedAttr = this._selectValue;
    });
  }

  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.attrList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            this._changeAttr('${item['title']}', attrItem.cate, setBottomState);
          },
          child: Chip(
            label: Text('${item['title']}'),
            padding: EdgeInsets.all(10),
            backgroundColor: item['checked'] ? Colors.red : Colors.black12,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  List<Widget> _getAttrWidget(setBottomState) {
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: ScreenAdapter.width(590),
            child: Wrap(
              children: this._getAttrItemWidget(attrItem, setBottomState),
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
          return StatefulBuilder(
            builder: (context, setBottomState) {
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
                            children: this._getAttrWidget(setBottomState),
                          ),
                          Divider(),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            height: ScreenAdapter.height(80),
                            child: Row(
                              children: <Widget>[
                                Text("数量: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 10),
                                ProductNum(this._productContent)
                              ],
                            ),
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
                              callBack: () async {
                                print('加入购物车');
                                await CartServices.addCart(this._productContent);

                                //调用Provider 更新数据
                                this.cartProvider.updateCartList();
                                //关闭底部筛选属性
                                Navigator.of(context).pop();
                                JKToast.sendMsg('加入购物车成功');
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
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    this.cartProvider = Provider.of<CartProvider>(context);

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
          this._attr.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenAdapter.height(80),
                  child: InkWell(
                    onTap: () {
                      print(this._productContent.attr);
                      this._attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text('已选: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${this._selectValue}')
                      ],
                    ),
                  ),
                )
              : Text(''),
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
