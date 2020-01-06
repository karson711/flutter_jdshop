import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';
import '../../widget/JDBottimBtn.dart';

class ProductDetailFristPage extends StatefulWidget {
  ProductDetailFristPage({Key key}) : super(key: key);

  @override
  _ProductDetailFristPageState createState() => _ProductDetailFristPageState();
}

class _ProductDetailFristPageState extends State<ProductDetailFristPage> {
  Widget _screenConditionWidget() {
    return Wrap(
      children: <Widget>[
        Container(
          width: ScreenAdapter.width(100),
          child: Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
            child: Text(
              '颜色: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenAdapter.size(32)),
            ),
          ),
        ),
        Container(
          width: ScreenAdapter.width(610),
          child: Wrap(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text('白色'),
                  padding: EdgeInsets.all(10),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text('白色'),
                  padding: EdgeInsets.all(10),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text('白色'),
                  padding: EdgeInsets.all(10),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text('白色'),
                  padding: EdgeInsets.all(10),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text('白色'),
                  padding: EdgeInsets.all(10),
                ),
              )
            ],
          ),
        )
      ],
    );
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
                        children: <Widget>[
                          this._screenConditionWidget(),
                          this._screenConditionWidget(),
                          this._screenConditionWidget(),
                        ],
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

    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: ListView(
        children: <Widget>[
          //图片
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network('https://www.itying.com/images/flutter/p1.jpg',
                fit: BoxFit.cover),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '联想ThinkPad 翼480（0VCD） 英特尔酷睿i5 14英寸轻薄窄边框笔记本电脑',
              maxLines: 2,
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdapter.size(36)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '震撼首发，15.9毫米全金属外观，4.9毫米轻薄窄边框，指纹电源按钮，杜比音效，2G独显，预装正版office软件',
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
                      Text('¥28',
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
                        '¥50',
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
