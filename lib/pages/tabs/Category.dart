import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    //左侧宽度
    var leftWidth = ScreenAdapter.getScreenWidthDP() / 4;

    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3
    var rightItemWidth = (ScreenAdapter.getScreenWidthDP()-leftWidth-20-20)/3;
    //获取计算后的宽度
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    //获取计算后的高度
    var rightItemHeight = rightItemWidth+ScreenAdapter.height(28);

    return Row(
      children: <Widget>[
        Container(
          width: leftWidth,
          height: double.infinity,
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        this._selectIndex = index;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(50),
                      child: Text('第${index}条'),
                      color: this._selectIndex == index
                          ? Colors.red
                          : Colors.white,
                    ),
                  ),
                  Divider()
                ],
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            color: Color.fromRGBO(240, 246, 246, 0.9),
            padding: EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rightItemWidth / rightItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: 18,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1/1,
                      child: Image.network('https://www.itying.com/images/flutter/list8.jpg',fit: BoxFit.fill),
                    ),
                    Container(
                      height: ScreenAdapter.height(28),
                      child: Text('女装'),
                    )
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
