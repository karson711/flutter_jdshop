import 'package:flutter/material.dart';

import 'package:flutter_jdshop/routers/router.dart' as prefix0;
import 'package:provider/provider.dart';
import 'package:flutter_jdshop/providers/CartProvider.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: prefix0.onGenerateRoute,
        theme: ThemeData(primaryColor: Colors.white),
      ),
    );
  }
}
