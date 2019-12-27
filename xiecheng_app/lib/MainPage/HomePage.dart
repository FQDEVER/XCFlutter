
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/grid_nav_model.dart';
import 'package:xiecheng_app/widget/Tool/appbar_widget.dart';
import 'package:xiecheng_app/widget/Tool/loading_control_widget.dart';
import 'package:xiecheng_app/widget/activityView_widget.dart';
import 'package:xiecheng_app/widget/local_nav_widget.dart';
import 'package:xiecheng_app/widget/project_information.dart';
import 'package:xiecheng_app/widget/sub_nav_widget.dart';
import 'package:xiecheng_app/model/sales_box_model.dart';
import 'package:xiecheng_app/widget/webView_widget.dart';
import 'package:xiecheng_app/widget/Tool/appbar_widget.dart';
import 'package:xiecheng_app/DetailPage/home_detail_file/home_search_detail_page.dart';

const double AppBarOpacityChangeMaxH = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CommonModel> imglists = [];
  List<CommonModel> localModelList = [];
  List<CommonModel> subNavList = [];
  double _scrollerAppBarOpacity = 0;
  GridNavModel gridNavModel;
  SalesBoxModel salesBoxModel;
  bool _loading = true;

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

  loadData() {
    HomeDao.fetch().then((result) {
      setState(() {
        imglists = result.bannerList;
        localModelList = result.localNavList;
        subNavList = result.subNavList;
        gridNavModel = result.gridNav;
        salesBoxModel = result.salesBoxModel;
        _loading = false;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoadingControl(
        cover: true,
        isloading: _loading,
        child: MediaQuery.removePadding(
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
                child: _homeContentWidget,
              ),
              _appBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(
                  (_scrollerAppBarOpacity * 255).toInt(), 255, 255, 255),
            ),
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AppBarView(
                placeholder: "网红打卡地 景点 酒店 美食",
                city: "上海",
                searchBarType: _scrollerAppBarOpacity > 0.2
                    ? SearchBarType.homeLight
                    : SearchBarType.home,
                inputBoxClick: () {
                  print("跳转搜索");
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return HomeSearchPage();
                  }));
                },
                leftButtonClick: () {
                  print("城市选择界面");
                },
                speakButtonClick: () {
                  print("语音按钮");
                },
                righButtonClick: () {
                  print("评论按钮");
                },
              ),
            ),
          ),
        ),
        Container(
          height: _scrollerAppBarOpacity > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.5)],
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget get _homeContentWidget {
    return ListView(
      children: <Widget>[
        Container(
          height: 160,
          child: Swiper(
            itemCount: imglists.length,
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              CommonModel model = imglists[index];
              return Image.network(
                model.icon,
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
          child: ProjectInformationWidget(
            gridNavModel: gridNavModel,
          ),
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
    );
  }
}
