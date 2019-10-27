import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/widget/local_nav_widget.dart';

const double AppBarOpacityChangeMaxH = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> imglists = [];
  List<CommonModel>localModelList = [];
  double _scrollerAppBarOpacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void _onScroller(offSexY) {
    print("$offSexY");

    double opacity = offSexY / AppBarOpacityChangeMaxH;
    if (opacity < 0) {
      opacity = 0;
    } else if (opacity > 1) {
      opacity = 1;
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
                      Container(
                          height: 800,
                          child: ListTile(
                            title: Text("哈哈"),
                          ))
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
