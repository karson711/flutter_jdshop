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
            onTap: () {},
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
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
