import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static init(context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
  }

  static height(double value) {
    return ScreenUtil.getInstance().setHeight(value);
  }

  static width(double value) {
    return ScreenUtil.getInstance().setWidth(value);
  }

  static getScreenHeightDP() {
    return ScreenUtil.screenHeightDp;
  }

  static getScreenWidthDP() {
    return ScreenUtil.screenWidthDp;
  }

  static getScreenHeightPX() {
    return ScreenUtil.screenHeight;
  }

  static getScreenWidthPX() {
    return ScreenUtil.screenWidth;
  }
}
