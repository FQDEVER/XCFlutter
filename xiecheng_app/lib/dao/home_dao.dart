

import 'package:xiecheng_app/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xiecheng_app/model/search_model.dart';
const Home_Url = "http://www.devio.org/io/flutter_app/json/home_page.json";

class HomeDao{
  static Future<HomeModel> fetch() async {
    final response = await http.get(Home_Url);
    if(response.statusCode == 200){

      /*修复中文乱码*/
      Utf8Decoder utf8decoder = Utf8Decoder();

      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    }else{
      throw Exception("Failed to load home_page.json");
    }
  }
}

class SearchDataDao{
  static Future<SearchModel> fetch(String url,String text) async {
    final response = await http.get(url);
    if(response.statusCode == 200){

      /*修复中文乱码*/
      Utf8Decoder utf8decoder = Utf8Decoder();

      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    }else{
      throw Exception("Failed to load search_page.json");
    }
  }
}