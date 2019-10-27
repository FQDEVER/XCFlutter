

import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/config_model.dart';
import 'package:xiecheng_app/model/grid_nav_model.dart';
import 'package:xiecheng_app/model/sales_box_model.dart';

class HomeModel{

  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBoxModel;

  HomeModel({this.config,this.bannerList,this.localNavList,this.gridNav,this.subNavList,this.salesBoxModel});
  
  factory HomeModel.fromJson(Map<String,dynamic>json){
    var localNavListJson = json["localNavList"] as List;
    var bannerListJson = json["bannerList"] as List;
    var subNavListJson = json["subNavList"] as List;
    List<CommonModel> localNavList = localNavListJson.map((i)=> CommonModel.fromJson(i)).toList();
    List<CommonModel> bannerList = bannerListJson.map((i)=> CommonModel.fromJson(i)).toList();
    List<CommonModel> subNavList = subNavListJson.map((i)=> CommonModel.fromJson(i)).toList();
    return HomeModel(
      localNavList: localNavList,
      bannerList: bannerList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json["config"]),
      gridNav: GridNavModel.fromJson(json["gridNav"]),
      salesBoxModel: SalesBoxModel.fromJson(json["salesBoxModel"]),
    );
  }
}
