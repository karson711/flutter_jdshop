import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../widget/LoadingWidget.dart';

class ProductDetailSecondPage extends StatefulWidget {
  final List _productContentList;

  ProductDetailSecondPage(this._productContentList, {Key key})
      : super(key: key);

  @override
  _ProductDetailSecondPageState createState() =>
      _ProductDetailSecondPageState();
}

class _ProductDetailSecondPageState extends State<ProductDetailSecondPage>
    with AutomaticKeepAliveClientMixin {
  bool _flag = true;
  InAppWebViewController webView;
  var _id;
  String _url;

  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this._id = widget._productContentList[0].sId;
    setState(() {
      this._url = 'http://jd.itying.com/pcontent?id=${this._id}';
    });
  }

  @override
  Widget build(BuildContext context) {
    print('http://jd.itying.com/pcontent?id=${this._id}');
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: '${this._url}',
              initialHeaders: {},
              initialOptions: InAppWebViewWidgetOptions(
                inAppWebViewOptions:
                    InAppWebViewOptions(debuggingEnabled: true),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this._flag = false;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
