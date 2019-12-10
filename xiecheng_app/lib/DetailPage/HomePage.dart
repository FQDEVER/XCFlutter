import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/grid_nav_model.dart';
import 'package:xiecheng_app/widget/activityView_widget.dart';
import 'package:xiecheng_app/widget/local_nav_widget.dart';
import 'package:flutter/services.dart';
import 'package:xiecheng_app/widget/project_information.dart';
import 'package:xiecheng_app/widget/sub_nav_widget.dart';
import 'package:xiecheng_app/model/sales_box_model.dart';


const double AppBarOpacityChangeMaxH = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> imglists = [];
  List<CommonModel>localModelList = [];
  List<CommonModel> subNavList = [];
  double _scrollerAppBarOpacity = 0;
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void _onScroller(offSexY) {
    print("$offSexY");

    double opacity = offSexY / AppBarOpacityChangeMaxH;
    if (opacity <= 0) {
      opacity = 0;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else if (opacity >= 1) {
      opacity = 1;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    setState(() {
      _scrollerAppBarOpacity = opacity;
    });
  }

  loadData(){
    HomeDao.fetch().then((result){
      setState(() {
        imglists = result.bannerList;
        localModelList = result.localNavList;
        subNavList = result.subNavList;
        gridNavModel = result.gridNav;
        salesBoxModel = result.salesBoxModel;
      });
    }).catchError((e){
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf2f2f2),
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Stack(

            children: <Widget>[
              NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification &&
                        notification.depth == 0) {
                      _onScroller(notification.metrics.pixels);
                    }
                    return true;
                  },
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 160,
                        child: Swiper(
                          itemCount: imglists.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            CommonModel model = imglists[index];
                            return Image.network(
                              model.icon ,
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                      child: LocalNavWidget(localModelList: localModelList),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: ProjectInformationWidget(gridNavModel: gridNavModel,),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: HomeSubNavWidget(commonModels: subNavList),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
                        child: ActivityViewWidget(salesBoxModel: salesBoxModel),
                      ),
                    ],
                  )),
              Opacity(
                opacity: _scrollerAppBarOpacity,
                child: Container(
                  height: 80,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("首页",
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
