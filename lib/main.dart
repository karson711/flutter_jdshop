import 'package:flutter/material.dart';

import 'package:flutter_jdshop/routers/router.dart' as prefix0;
import 'package:provider/provider.dart';
import 'package:flutter_jdshop/providers/CartProvider.dart';
import 'package:flutter_jdshop/providers/CheckOutProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckOutProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        //routes优先执行，所以必须注释掉，否则onGenerateRoute方法不会调用
        onGenerateRoute: prefix0.onGenerateRoute,
        theme: ThemeData(primaryColor: Colors.white),
      ),
    );
  }
}
