import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(10),
          height: ScreenAdapter.height(68),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromRGBO(233, 233, 233, 0.8)
          ),
          child: TextField(
            autofocus: true,
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
        child: Text('搜索'),
      ),
    );
  }
}
