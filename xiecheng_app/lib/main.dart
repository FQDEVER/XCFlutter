import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xiecheng_app/NavigationManager.dart';
import 'package:flutter/services.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';

void main() {
  runApp(MyApp());
  AmapCore.init('9e1a89c9e9ab7510b75a5882f26cc799');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    )
    );
  }
}

