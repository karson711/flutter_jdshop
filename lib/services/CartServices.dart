class CartServices {
  static addCart(item) {
    item = CartServices.formatCartData(item);
    print(item);
  }

  static formatCartData(item) {
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price;
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    //是否选中
    data['checked'] = true;    
    return data;
  }
}
