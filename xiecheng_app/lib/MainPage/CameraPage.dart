import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/WeatherModel.dart';
import 'package:xiecheng_app/dao/home_dao.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}


class _CameraPageState extends State<CameraPage> {
  //写一个漂亮的天气界面
  WeatherModel weatherModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    WeatherDao.fetch("深圳").then((result) {
      setState(() {
        weatherModel = result;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(weatherModel == null ? "请求中" : weatherModel.cityEn),
    );
  }
}
