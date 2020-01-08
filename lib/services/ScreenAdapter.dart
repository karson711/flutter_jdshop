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

  static fulWidth() {
    return ScreenUtil.getInstance().setWidth(750);
  }

  static getScreenHeight() {
    return ScreenUtil.screenHeightDp;
  }

  static getScreenWidth() {
    return ScreenUtil.screenWidthDp;
  }

  static getScreenPXHeight() {
    return ScreenUtil.screenHeight;
  }

  static getScreenPXWidth() {
    return ScreenUtil.screenWidth;
  }

  static size(double fontSize) {
    return ScreenUtil.getInstance().setSp(fontSize);
  }
}
