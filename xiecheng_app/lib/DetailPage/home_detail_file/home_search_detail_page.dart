
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xiecheng_app/widget/Tool/appbar_widget.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: <Widget>[
          _appBar(context),
          Container(
            child: Text("测试"),
          )
        ],
      )
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
              color: Colors.white,
            ),
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AppBarView(
                placeholder: "网红打卡地 景点 酒店 美食",
                searchBarType: SearchBarType.search,
                leftButtonClick: () {
                  print("返回界面");
                  Navigator.pop(context);
                },
                speakButtonClick: () {
                  print("语音按钮");
                },
                righButtonClick: () {
                  print("搜索按钮");
                },
                onChanged: (String valueStr){
                  print(valueStr);
                },
              ),
            ),
          ),
        ),
        Container(
          height:  0.5,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 0.5)],
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
