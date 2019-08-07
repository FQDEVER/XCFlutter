import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const double AppBarOpacityChangeMaxH = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> img_lists = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564943643372&di=0cc029b22b6087cdf4e47c82ec059254&imgtype=0&src=http%3A%2F%2Fpic24.nipic.com%2F20121012%2F6659396_153724664149_2.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564943643372&di=5c4643b07d6f0d57afe6c28bb4e457ab&imgtype=0&src=http%3A%2F%2Fpic163.nipic.com%2Ffile%2F20180426%2F6083536_223757111031_2.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564943643372&di=20f3c791d40450b49380e8e7b04c72bb&imgtype=0&src=http%3A%2F%2Fpic.rmb.bdstatic.com%2Ff54083119edfb83c4cfe9ce2eeebc076.jpeg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564943643371&di=d34615babfa668030f434f56fa1ec758&imgtype=0&src=http%3A%2F%2Fpic30.nipic.com%2F20130612%2F12724384_085414541114_2.jpg",
  ];
  double _scrollerAppBarOpacity = 0;

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

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Stack(
          children: <Widget>[
            NotificationListener(
                onNotification: (scrollerNotification) {
                  if (scrollerNotification is ScrollUpdateNotification &&
                      scrollerNotification.depth == 0) {
                    _onScroller(scrollerNotification.metrics.pixels);
                  }
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 160,
                      child: Swiper(
                        itemCount: img_lists.length,
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            img_lists[index],
                            fit: BoxFit.fill,
                          );
                        },
                        pagination: SwiperPagination(),
                      ),
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
                    child: Text("首页"),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
