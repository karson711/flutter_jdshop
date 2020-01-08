import 'package:event_bus/event_bus.dart';

//Bus初始化
EventBus eventBus = EventBus();

class ProductDetailEvent {
  String str;
  ProductDetailEvent(String str) {
    this.str = str;
  }
}
