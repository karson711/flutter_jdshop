import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class ProductDetailEvent {
  String str;
  ProductDetailEvent(String str) {
    this.str = str;
  }
}

//用户中心广播
class UserEvent{
  String str;
  UserEvent(String str){
    this.str=str;
  }
}

//地址广播
class AddressEvent{
  String str;
  AddressEvent(String str){
    this.str=str;
  }
}

//结算页面广播
class CheckOutEvent{
  String str;
  CheckOutEvent(String str){
    this.str=str;
  }
}
