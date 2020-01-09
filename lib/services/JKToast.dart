import 'package:fluttertoast/fluttertoast.dart';

class JKToast {
  static sendMsg(msg) {
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
  
}
