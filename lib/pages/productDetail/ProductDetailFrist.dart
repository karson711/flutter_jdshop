import 'package:flutter/material.dart';
import '../../services/ScreenAdapter.dart';

class ProductDetailFristPage extends StatefulWidget {
  ProductDetailFristPage({Key key}) : super(key: key);

  @override
  _ProductDetailFristPageState createState() => _ProductDetailFristPageState();
}

class _ProductDetailFristPageState extends State<ProductDetailFristPage> {
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
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text('已选: ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('115，黑色，XL，1件')
              ],
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
