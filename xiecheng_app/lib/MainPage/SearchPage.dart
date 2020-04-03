import 'dart:wasm';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/search_model.dart';
import 'package:xiecheng_app/widget/Tool/appbar_widget.dart';
import 'package:xiecheng_app/dao/home_dao.dart';
import 'package:xiecheng_app/widget/webView_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


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

const List imgList = [
  "http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg",
  "http://yanxuan.nosdn.127.net/8b30eeb17c831eba08b97bdcb4c46a8e.png",
  "http://yanxuan.nosdn.127.net/a196b367f23ccfd8205b6da647c62b84.png",
  "http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png",
  "http://yanxuan.nosdn.127.net/88dc5d80c6f84102f003ecd69c86e1cf.png",
  "http://yanxuan.nosdn.127.net/8b9328496990357033d4259fda250679.png",
  "http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png",
  "http://yanxuan.nosdn.127.net/ee92704f3b8323905b51fc647823e6e5.png",
  "http://yanxuan.nosdn.127.net/e564410546a11ddceb5a82bfce8da43d.png",
  "http://yanxuan.nosdn.127.net/56f4b4753392d27c0c2ccceeb579ed6f.png",
  "http://yanxuan.nosdn.127.net/6a54ccc389afb2459b163245bbb2c978.png",
  'https://picsum.photos/id/101/548/338',
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569842561051&di=45c181341a1420ca1a9543ca67b89086&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201504%2F17%2F20150417212547_VMvrj.jpeg',
  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1570437233&di=9239dbc3237f1d21955b50e34d76c9d5&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201508%2F30%2F20150830095308_UAQEi.thumb.700_0.jpeg'
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
    return OKToast(
        child: new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("搜索"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: AppBarView(
                    placeholder: "请输入搜索内容",
                    searchBarType: SearchBarType.search,
                    hiddenLeftBtn: true,
                    righButtonClick: () {
                       showToast(widget.keyword !=null ? "${widget.keyword}" : "暂无搜索关键字");
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
                  child:StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(8.0),
                      crossAxisCount: 4,
                      itemCount: imgList.length,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      itemBuilder: (context,i){
                        return Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: new InkWell(
                            onTap: (){
                              showToast("点击瀑布流");
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) {
                                    // return new FullScreenImagePage(imgPath);
                                    return null;
                                  },
                                ),
                              );
                            },
                            child: Hero(
                                tag: imgList[i],
                                child: Image.network(imgList[i],fit: BoxFit.fitWidth,)),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index){
                       return StaggeredTile.fit(2);
                      }),
                  
//                  MediaQuery.removePadding(
//                      removeTop: true,
//                      context: context,
//                      child: ListView.builder(
//                          itemCount: widget.searchModel?.data?.length ?? 0,
//                          itemBuilder: (BuildContext context, int index) {
//                            return _item(index, context);
//                          }))
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _item(int index, BuildContext context) {
    if (widget.searchModel == null || widget.searchModel.data == null) {
      return Text("aa");
    }
    SearchItem searchItem = widget.searchModel.data[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
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
            Image.asset(
              _getSearchItemImage(searchItem),
              width: 20,
              height: 20,
              color: Colors.blue,
            ),
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

    List<TextSpan> spans = [];
    //将字符串拆分
    List<String> arr = searchItem.word.split(widget.keyword);
    TextStyle norStyle = TextStyle(color: Colors.black);
    TextStyle selStyle = TextStyle(color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if (i % 2 == 0) {
        if (arr[i].length > 0 && arr[i] != null) {
          spans.add(TextSpan(text: arr[i], style: norStyle));
        }
      } else {
        spans.add(TextSpan(text: arr[i], style: selStyle));
      }
    }
    return spans;
//    List<>
  }

  _subTitle(SearchItem searchItem) {
    return Text(searchItem.zonename);
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
//      print("搜索错误:$error");
    });
  }
}
