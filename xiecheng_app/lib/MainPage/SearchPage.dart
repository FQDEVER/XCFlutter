import 'dart:wasm';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/search_model.dart';
import 'package:xiecheng_app/widget/Tool/appbar_widget.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/widget/webView_widget.dart';

const kSearchUrl =
    "https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contenType=json&keyword=";
const kTypes = [
  "channelgroup",
  "gs",
  "plane",
  "train",
  "cruise",
  "district",
  "food",
  "hotel",
  "huodong",
  "shop",
  "sight",
  "ticket",
  "travelgroup"
];

class SearchPage extends StatefulWidget {
  SearchModel searchModel;
  String keyword;

  SearchPage({
    this.searchModel,
    this.keyword,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: AppBarView(
                  placeholder: "请输入搜索内容",
                  searchBarType: SearchBarType.search,
                  hiddenLeftBtn: true,
                  righButtonClick: () {
                    print("点击搜索按钮");
                  },
                  onChanged: (String text) {
                    print("------------->text-/$text");
                    _onTextChange(text);
                  },
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                        itemCount: widget.searchModel?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return _item(index, context);
                        }))),

          ],
        ),
      ),
    );
  }

  _item(int index, BuildContext context) {
    if (widget.searchModel == null || widget.searchModel.data == null) {
      return Text("aa");
    }
    SearchItem searchItem = widget.searchModel.data[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (BuildContext context) {
          CommonModel commonModel = CommonModel();
          commonModel.url = searchItem.url;
          return FQWebView(commonModel: commonModel);
        }));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.3),
          ),
        ),
        child: Row(
          children: <Widget>[
            Image.asset(_getSearchItemImage(searchItem), width: 20,
              height: 20,
              color: Colors.blue,),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(searchItem.word),
                  Text(searchItem.type),
//                  _title(searchItem),
//                  _subTitle(searchItem),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _title(SearchItem searchItem) {
    if (searchItem == null) {
      return null;
    }

    List<TextSpan>spans = [];
    //将字符串拆分
    List<String> arr = searchItem.word.split(widget.keyword);
    TextStyle norStyle = TextStyle(color: Colors.black);
    TextStyle selStyle = TextStyle(color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if (i % 2 == 0) {
        if (arr[i].length > 0 && arr[i] != null) {
          spans.add(TextSpan(text: arr[i], style: norStyle));
        }
      }else{
        spans.add(TextSpan(text: arr[i],style:selStyle));
      }
    }
    return spans;
//    List<>
  }

  _subTitle(SearchItem searchItem) {
    return  Text(searchItem.zonename);
  }


  String _getSearchItemImage(SearchItem searchItem) {
    if (searchItem.type == null) {
      return "images/type_travelgroup.png";
    }

    String path = "travelgroup";
    for (final value in kTypes) {
      if (searchItem.type.contains(value)) {
        path = value;
        return "images/type_$path.png";
      }
    }
    return "images/type_$path.png";
  }

  _onTextChange(String text) {
    widget.keyword = text;
    if (text.length == 0) {
      setState(() {
        widget.searchModel = null;
      });
      return;
    }
    String url = kSearchUrl + text;
    SearchDataDao.fetch(url, text).then((SearchModel searchModel) {
      if (searchModel.keyword == widget.keyword) {
        setState(() {
          widget.searchModel = searchModel;
        });
      }
    }).catchError((error) {
      print("搜索错误:$error");
    });
  }
}
