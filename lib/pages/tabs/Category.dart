import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';
import 'package:flutter_jdshop/config/Config.dart';
import 'package:dio/dio.dart';
import '../../model/CateModel.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;
  List _leftList = [];
  List _rightList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getLeftListData();
  }

  //获取左侧分类
  void _getLeftListData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    print(result);
    var leftList = CateModel.fromJson(result.data);
    setState(() {
      this._leftList = leftList.result;
    });
    if (leftList.result.length > 0) {
      this._getRightListData(this._leftList[0].sId);
    }
  }

  //获取右侧分类
  void _getRightListData(pid) async {
    var api = '${Config.domain}api/pcate?pid=${pid}';
    var result = await Dio().get(api);
    print(result);
    var rightList = CateModel.fromJson(result.data);
    setState(() {
      this._rightList = rightList.result;
    });
  }

  //左侧分类
  Widget _leftCateWidget(leftWidth) {
    if (this._leftList.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        color: Color.fromRGBO(240, 246, 246, 0.9),
        child: ListView.builder(
          itemCount: this._leftList.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      this._selectIndex = index;
                      this._getRightListData(this._leftList[index].sId);
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
                    child: Text('${this._leftList[index].title}',
                        textAlign: TextAlign.center),
                    color: this._selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                Divider(height: 1)
              ],
            );
          },
        ),
      );
    } else {
      return Container(
          width: leftWidth,
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9));
    }
  }

  //右侧分类
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (this._rightList.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          color: Color.fromRGBO(240, 246, 246, 0.9),
          padding: EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: rightItemWidth / rightItemHeight,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: this._rightList.length,
            itemBuilder: (context, index) {
              
              String pic = this._rightList[index].pic;
              pic = Config.domain+pic.replaceAll('\\', '/');

              return Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                        '${pic}',
                        fit: BoxFit.cover),
                  ),
                  Container(
                    height: ScreenAdapter.height(28),
                    child: Text('${this._rightList[index].title}'),
                  )
                ],
              );
            },
          ),
        ),
      );
    } else {
      return Expanded(
          flex: 1,
          child: Container(
              color: Color.fromRGBO(240, 246, 246, 0.9),
              padding: EdgeInsets.all(10),
              child: Text('')));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    //左侧宽度
    var leftWidth = ScreenAdapter.getScreenWidthDP() / 4;
    //右侧每一项宽度=（总宽度-左侧宽度-GridView外侧元素左右的Padding值-GridView中间的间距）/3
    var rightItemWidth =
        (ScreenAdapter.getScreenWidthDP() - leftWidth - 20 - 20) / 3;
    //获取计算后的宽度
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    //获取计算后的高度
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Row(
      children: <Widget>[
        this._leftCateWidget(leftWidth),
        this._rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }
}
