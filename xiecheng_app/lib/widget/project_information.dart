import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/grid_nav_model.dart';
import 'package:xiecheng_app/widget/webView_widget.dart';

class ProjectInformationWidget extends StatelessWidget {
  final GridNavModel gridNavModel;

  const ProjectInformationWidget({Key key, @required this.gridNavModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _items(context);
  }

  _items(BuildContext context) {
    if (gridNavModel == null) return Text("");
    GridNavItem hotelNavItem =  gridNavModel.hotel;
    GridNavItem flightNavItem = gridNavModel.flight;
    GridNavItem travelNavItem = gridNavModel.travel;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: PhysicalModel(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              _columnGridView(context, hotelNavItem,true),
              _columnGridView(context, flightNavItem,false),
              _columnGridView(context, travelNavItem,false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _columnGridView(BuildContext context, GridNavItem navItem,bool isFirst) {
    Color startColor = Color(int.parse("0xff" + navItem.startColor));
    Color endColor = Color(int.parse("0xff" + navItem.endColor));
    //添加一个水平的
    return Container(
      height: 88,
      margin: isFirst ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor,endColor]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Expanded(

            child: _mainItem(context, navItem.mainItem),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(child: _item(context, navItem.item1,true)),
                Expanded(child: _item(context, navItem.item2,false)),
              ],
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(child: _item(context, navItem.item3,true)),
              Expanded(child: _item(context, navItem.item4,false)),
            ],
          )),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, CommonModel model ,bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8,color: Colors.white);
    return  FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: borderSide,
              bottom: isFirst ? borderSide : BorderSide.none,
            )
          ),
          child: GestureDetector(
            onTap: () {
//            print("跳转到${model.url}");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return FQWebView(commonModel: model);
                }),
              );
            },
            child:Center(
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                ),
              ),
            ),
        ),
      )
    );
  }

  Widget _mainItem(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
//            print("跳转到${model.url}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return FQWebView(commonModel: model);
          }),
        );
      },

      child:Container(
        child:  Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Image.network(
                  model.icon,
                  fit: BoxFit.contain,
                height: 88,
                width: 121,
                alignment: AlignmentDirectional.bottomEnd,
              ),
              Container(
                margin: const EdgeInsets.only(top: 11),
                child: Text(
                    model.title,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,)
                ),
              ),
            ],
      ),
      ),
    );
  }
}
