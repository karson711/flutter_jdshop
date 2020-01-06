import 'dart:convert';
import '../services/Storage.dart';

class SearchServices {
  static addHistoryData(keyWords) async {
    /*
          1、获取本地存储里面的数据  (searchList)
          2、判断本地存储是否有数据
              2.1、如果有数据 
                    1、读取本地存储的数据
                    2、判断本地存储中有没有当前数据，
                        如果有不做操作、
                        如果没有当前数据,本地存储的数据和当前数据拼接后重新写入           
              2.2、如果没有数据
                    直接把当前数据放在数组中写入到本地存储      
      */
    try {
      List searchListData =
          json.decode(await Storage.getString('searchList'));
      print(searchListData);
      var hasData = searchListData.any((v) {
        return v == keyWords;
      });
      if (!hasData) {
        searchListData.add(keyWords);
        print(searchListData);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } catch (e) {
      List searchListData = [];
      searchListData.add(keyWords);
      print(searchListData);
      await Storage.setString('searchList', json.encode(searchListData));
    }
  }

  static getHistoryListData() async {
    try {
      List searchListData =
          json.decode(await Storage.getString('searchList'));
      print(searchListData);
      return searchListData;
    } catch (e) {
      print('返回空数组');
      return [];
    }
  }

  static removeHistoryData(keyWords) async {
    List searchListData =
        json.decode(await Storage.getString('searchList'));
    searchListData.remove(keyWords);
    await Storage.setString('searchList', json.encode(searchListData));
  }

  static clearHistoryData() async {
    await Storage.remove('searchList');
  }
}
