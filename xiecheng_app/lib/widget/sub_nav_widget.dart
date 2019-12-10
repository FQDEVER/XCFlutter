
import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'webView_widget.dart';

class HomeSubNavWidget extends StatefulWidget {
  final List<CommonModel>commonModels;
  const HomeSubNavWidget({Key key,@required this.commonModels}):super(key : key);
  @override
  _HomeSubNavWidgetState createState() => _HomeSubNavWidgetState();
}

class _HomeSubNavWidgetState extends State<HomeSubNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child:  _items(context)
      );
  }

  Widget _items(BuildContext context){

    if(widget.commonModels == null){
      return null;
    }

    List<Widget>items = [];
    widget.commonModels.forEach((model){
      items.add(_item(context, model));
    });
    int separate = (widget.commonModels.length * 0.5 + 0.5).toInt();
    //获取前5个以及后5个
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.sublist(0,separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.sublist(separate,widget.commonModels.length),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context,CommonModel model){
    return Container(
      height: 64,
      child: GestureDetector(
        onTap: (){
//            print("跳转到${model.url}");
          Navigator.push(context,
            MaterialPageRoute(builder:(BuildContext context){
              return FQWebView(commonModel: model);
            }),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(model.icon,width: 18,height: 18),
            Text(model.title,style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
