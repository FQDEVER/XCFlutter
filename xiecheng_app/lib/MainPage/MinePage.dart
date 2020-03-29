import 'dart:convert' as JSON;

import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  //linetype 1是高的 2是缩头的分割线
  //type 0 是有value和箭头 1是只有箭头 2是只有开关 3是只有文本
  var jsonText1 = '[{"title": "车辆管理","value": "粤B3232ls","linetype": "1","type": "0"},{"title": "车辆授权","value": "","linetype": "2","type": "1"},{"title": "重置登录密码","value": "","linetype": "1","type": "1"},{"title": "手势密码","value": "1","linetype": "2","type": "2"},{"title": "重置手势密码","value": "","linetype": "2","type": "1"},{"title": "意见反馈","value": "","linetype": "1","type": "1"},{"title": "客服电话","value": "400-10220-1022","linetype": "2","type": "3"},{"title": "救援电话","value": "3202923920","linetype": "2","type": "3"}]';
  List<MineItemModel> models = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List list = JSON.jsonDecode(this.jsonText1);
    for(int i = 0;i < list.length;i++){
      var itemJson = list[i];
      MineItemModel model = MineItemModel.fromJson(itemJson);
      this.models.add(model);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF363644),
      appBar: AppBar(
        backgroundColor: Color(0xFF363644),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.crop_free),
            onPressed: (){
              showDialog(context: context,barrierDismissible: true,builder: (BuildContext context){
                return AlertDialog(
                  title: Title(color: Colors.black, child: Text("扫描")),
                  content: Text("扫描界面"),
                  actions: <Widget>[
                    FlatButton(onPressed: (){

                    }, child: Text("确定")),
                  ],
                );
              });
            },
            tooltip: 'remove the selected item',
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder:(BuildContext context,int index){
          if(index == 0){
            return  getUserItemCell();
          }else{
            MineItemModel model = models[index - 1];
            return  getMineItemCell(model);
          }
        },
        itemCount: models.length + 1,
      ),
    );
  }

  Widget getUserItemCell(){
    return new Container(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child:Container(
        color: Color(0xFF363644),
        height: 86,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0),child: Icon(Icons.supervised_user_circle,size: 60,color: Colors.white,)),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("UserName",style: TextStyle(fontSize: 20,color: Colors.white),),
                    Text("18565612312",style: TextStyle(fontSize: 12,color: Colors.white),),
                  ],
                )
              ],
            ),
            Icon(Icons.arrow_forward_ios,color: Colors.white,),
          ],
        ),
      )
    );
  }

  Widget getMineItemCell(MineItemModel model){
    return new Container(
      height: (model.linetype == "1"? (44.0 + 8) : (44.0 )),
      padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
      decoration: BoxDecoration(
        border: new Border(top: BorderSide(width: model.linetype == "1" ? 8 : 0,color: Colors.black,style: model.linetype == "1" ? BorderStyle.solid : BorderStyle.none)),
        color: Color(0xFF363644),
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(height: 1.0,indent: 35,color: Colors.black,),
          Expanded(child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.supervised_user_circle,size: 25,color: Color(0xFFCFAD7B),),
                  Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0),child: Text(model.title,style: TextStyle(color: Colors.white,fontSize: 15))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  this.getValueItemWidget(model),
                  this.getRightItemWidget(model),
                ],
              )
            ],
          ))
        ],
      )
    );
  }

  Widget getValueItemWidget(MineItemModel model){

    if(model.type == "0" || model.type == "3"){
      return Padding(padding: EdgeInsets.fromLTRB(8, 0, 0, 0),child: Text(model.value,style: TextStyle(color: model.type == "0" ? Colors.white : Color(0xFFCFAD7B),fontSize: 15)));
    }else{
      return Text("");
    }
  }

  Widget getRightItemWidget(MineItemModel model){

    if(model.type == "0" || model.type == "1"){
     return Icon(Icons.arrow_forward_ios,color: Colors.white,);
    }else if(model.type == "2"){
      return Switch(activeColor: Colors.red,value: model.value == "1", onChanged: (var bool){
        this.setState((){
          model.value = bool ? "1" : "0" ;
        });
      });
    }else{
      return Text("");
    }
  }
}


class MineItemModel {
  String title;
  String value;
  String linetype;
  String type;

  MineItemModel({this.title, this.value, this.linetype, this.type});

  MineItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    linetype = json['linetype'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['linetype'] = this.linetype;
    data['type'] = this.type;
    return data;
  }
}