import 'package:flutter/material.dart';
import 'package:xiecheng_app/MainPage/HomePage.dart';

import 'MainPage/CameraPage.dart';
import 'MainPage/MinePage.dart';
import 'MainPage/SearchPage.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
//  final PageController pageController = PageController(initialPage: 0);
  var _currentIndex = 0;
  final Color _normalColor = Colors.grey;
  final Color _selectColor = Colors.blue;

  void _clickVaigatorBarIndex(int index) {
//    pageController.jumpToPage(index);
    //跳转到对应的控制器
    setState(() {
      _currentIndex = index;
    });
  }

  //一种是使用page.一种是使用indexStack.
//  PageView(
//  controller: pageController,
//  physics: new NeverScrollableScrollPhysics(),
//  children: <Widget>[
//  //四个控制器
//  HomePage(),
//  SearchPage(),
//  CameraPage(),
//  MinePage(),
//  ],
//  ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          CameraPage(),
          MinePage(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _normalColor,
            ),
            title: Text(
              "首页",
              style: TextStyle(
                color: _currentIndex == 0 ? _selectColor : _normalColor,
                fontSize: 13,
              ),
            ),
            activeIcon: Icon(
              Icons.home,
              color: _selectColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _normalColor,
            ),
            title: Text(
              "搜索",
              style: TextStyle(
                color: _currentIndex == 1 ? _selectColor : _normalColor,
                fontSize: 13,
              ),
            ),
            activeIcon: Icon(
              Icons.search,
              color: _selectColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              color: _normalColor,
            ),
            title: Text(
              "旅拍",
              style: TextStyle(
                color: _currentIndex == 2 ? _selectColor : _normalColor,
                fontSize: 13,
              ),
            ),
            activeIcon: Icon(
              Icons.camera_alt,
              color: _selectColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: _normalColor,
            ),
            title: Text(
              "我的",
              style: TextStyle(
                color: _currentIndex == 3 ? _selectColor : _normalColor,
                fontSize: 13,
              ),
            ),
            activeIcon: Icon(
              Icons.account_circle,
              color: _selectColor,
            ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          _clickVaigatorBarIndex(index);
        },
      ),
    );
  }
}
