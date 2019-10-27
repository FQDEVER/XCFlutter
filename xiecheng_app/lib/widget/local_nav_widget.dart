
import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/widget/webView_widget.dart';

class LocalNavWidget extends StatelessWidget {
  final List<CommonModel>localModelList;
  const LocalNavWidget({Key key,@required this.localModelList}):super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
          padding: EdgeInsets.all(7),
          child: _items(context),
    ),
    );
  }

  _items(BuildContext context){
      if(localModelList == null)return null;
      List<Widget>itemWidget = [];
      localModelList.forEach((model){
        itemWidget.add(_item(context,model));
      });
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:itemWidget,
      );
    }

    Widget _item(BuildContext context,CommonModel model){
       return GestureDetector(
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
             Image.network(model.icon,width: 32,height: 32),
             Text(model.title,style: TextStyle(fontSize: 12),
             ),
           ],
         ),
       );
    }
}
