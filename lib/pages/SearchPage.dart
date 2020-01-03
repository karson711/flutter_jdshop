import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _hotSearchList = [
    '超级秒杀',
    '办公电脑',
    '儿童小电影',
    '唇彩唇蜜',
    '办公电脑',
    '儿童小电影',
    '唇彩唇蜜',
    '办公电脑',
    '儿童小电影',
    '唇彩唇蜜',
    '办公电脑',
    '儿童小电影',
    '唇彩唇蜜'
  ];
  List _historyList = [
    '超级秒杀',
    '办公电脑',
    '儿童小电影',
    '唇彩唇蜜',
    '办公电脑',
    '儿童小电影',
    '唇彩唇蜜'
  ];

  String _keyWords;

  Widget _topTitleWidget(context, title) {
    return Container(
      padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(title, style: Theme.of(context).textTheme.title),
          ),
          Divider()
        ],
      ),
    );
  }

  //热搜
  Widget _hotSearchWidget() {
    return Wrap(
      children: this._hotSearchList.map((value) {
        return Container(
          margin: EdgeInsets.all(ScreenAdapter.width(10)),
          padding: EdgeInsets.all(ScreenAdapter.width(10)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromRGBO(233, 233, 233, 0.9)),
          child: Text('$value'),
        );
      }).toList(),
    );
  }

  //历史记录
  Widget _historyRecordWidget() {
    return Container(
      child: Column(
        children: this._historyList.map((value) {
          return Container(
            padding: EdgeInsets.all(ScreenAdapter.width(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[Text('$value'), Divider()],
            ),
          );
        }).toList(),
      ),
    );
  }

  //icon和文字组成的按钮
  Widget _iconTitleWidget(Icon icon, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: ScreenAdapter.height(64),
      decoration: BoxDecoration(
          border:
              Border.all(color: Colors.black87, width: ScreenAdapter.width(1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[icon, Text('$title')],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(10),
          height: ScreenAdapter.height(68),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromRGBO(233, 233, 233, 0.8)),
          child: TextField(
            autofocus: false,
            onChanged: (value) {
              this._keyWords = value;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30))),
          ),
        ),
        actions: <Widget>[
          InkWell(
            child: Container(
              height: ScreenAdapter.height(68),
              width: ScreenAdapter.width(80),
              child: Row(
                children: <Widget>[Text('搜索')],
              ),
            ),
            onTap: () {
              if (this._keyWords != null) {
                Navigator.pushReplacementNamed(context, '/productList',
                    arguments: {"keyWords": this._keyWords});
              }else{
                print('请输入要搜索的内容');
              }
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.height(10)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(5)),
            this._topTitleWidget(context, '热搜'),
            this._hotSearchWidget(),
            SizedBox(height: ScreenAdapter.height(20)),
            this._topTitleWidget(context, '历史记录'),
            this._historyRecordWidget(),
            SizedBox(height: ScreenAdapter.height(80)),
            InkWell(
              child: this._iconTitleWidget(Icon(Icons.delete), '清空历史记录'),
              onTap: () {
                print('清空历史记录');
              },
            )
          ],
        ),
      ),
    );
  }
}
