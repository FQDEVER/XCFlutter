import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xiecheng_app/model/WeatherModel.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/widget/Tool/loading_control_widget.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  //写一个漂亮的天气界面
  WeatherModel weatherModel;
  Location _loc;
  String city;
  bool hasLocationStatusGranted; //默认为NO

  Future<bool> requestPermission() async {
    PermissionStatus value = await Permission.location.request();
    if (value == PermissionStatus.granted) {
      return true;
    } else {
      print('需要定位权限!');
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化
    requestPermission().then((bool value) {
      this.hasLocationStatusGranted = value;
      if (value) {
        AmapLocation.fetchLocation().then((Location value) {
          setState(() {
            _loc = value;
            this.loadData();
          });
        });
      } else {
        //未获取定位
        this.loadData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() {
    if (_loc != null) {
      //定位出来的包含市以及区.我们除开浦东新区.其他的市以及区全去掉
      if (_loc.city.endsWith("市")) {
        this.city = _loc.city.replaceAll("市", "");
      }

      if (_loc.city.endsWith("区") && !_loc.city.contains("浦东新区")) {
        this.city.replaceAll("区", "");
      }
    } else {
      this.city = "深圳";
    }

    WeatherDao.fetch(this.city).then((result) {
      setState(() {
        weatherModel = result;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (weatherModel == null) {
      return LoadingControl(
        child: Text(
          "加载中",
          style: TextStyle(color: Colors.red),
        ),
        isloading: true,
      );
    }

    if (this.hasLocationStatusGranted) {
      return this.getWeatherContentWidget(context);
    } else {
      return Center(
        child: Stack(
          children: <Widget>[
            this.getWeatherContentWidget(context),
            Padding(
                padding: EdgeInsets.only(top: 100, left: 30),
                child: InkWell(
                  child: Text(
                    "定位失败,请前往开启权限!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w200),
                  ),
                  onTap: () {
                  showToast("定位失败,请前往开启权限!");
                },
                ))
          ],
        ),
      );
    }
  }

  Widget getWeatherContentWidget(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          image: DecorationImage(
              image: AssetImage("images/weather.png"), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            this.weatherModel.data.first.tem,
                            style: TextStyle(
                                fontSize: 60,
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                          ),
                          Text(
                            this.weatherModel.data.first.wea,
                            style: TextStyle(
                                fontSize: 29,
                                color: Colors.white,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.weatherModel.countryEn,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            this.weatherModel.cityEn,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                  child: Text(
                    this.weatherModel.data.first.date,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.fromLTRB(26, 0, 0, 10),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: new BorderRadius.all(Radius.circular(3)),
                  ),
                  child: Text(
                    this.weatherModel.data.first.airTips,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(18, 0, 18, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        this.getWeatherOtherDayItemWidget(
                            this.weatherModel.data[1].week,
                            this.weatherModel.data[1].tem),
                        this.getWeatherOtherDayItemWidget(
                            this.weatherModel.data[2].week,
                            this.weatherModel.data[2].tem),
                        this.getWeatherOtherDayItemWidget(
                            this.weatherModel.data[3].week,
                            this.weatherModel.data[3].tem),
                        this.getWeatherOtherDayItemWidget(
                            this.weatherModel.data[4].week,
                            this.weatherModel.data[4].tem),
                        this.getWeatherOtherDayItemWidget(
                            this.weatherModel.data[5].week,
                            this.weatherModel.data[5].tem),
                        this.getWeatherOtherDayItemWidget(
                            this.weatherModel.data[6].week,
                            this.weatherModel.data[6].tem),
                      ],
                    )),
              ],
            )
          ],
        ));
  }

  Widget getWeatherOtherDayItemWidget(String weatherStr, String tem) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          weatherStr,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            tem,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
