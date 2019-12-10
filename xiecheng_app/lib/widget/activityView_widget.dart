import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/common_model.dart';
import 'package:xiecheng_app/model/sales_box_model.dart';
import 'package:xiecheng_app/widget/webView_widget.dart';

class ActivityViewWidget extends StatefulWidget {
  final SalesBoxModel salesBoxModel;

  const ActivityViewWidget({Key key, @required this.salesBoxModel})
      : super(key: key);

  @override
  _ActivityViewWidgetState createState() => _ActivityViewWidgetState();
}

class _ActivityViewWidgetState extends State<ActivityViewWidget> {
  CommonModel topViewModel = CommonModel();

  @override
  Widget build(BuildContext context) {
    if (widget.salesBoxModel == null) {
      return Center(
        child: Text(""),
      );
    }

    if (widget.salesBoxModel.moreUrl == null) {
      return Center(
        child: Text(""),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: <Widget>[
          _topView(context, topViewModel),
          _bigViews(context, widget.salesBoxModel.bigCard1,
              widget.salesBoxModel.bigCard2),
          _bigViews(context,widget.salesBoxModel.smallCard1,widget.salesBoxModel.smallCard2),
          _bigViews(context,widget.salesBoxModel.smallCard3,widget.salesBoxModel.smallCard4),
        ],
      ),
    );
  }

  Widget _bigViews(BuildContext context, CommonModel model1, CommonModel model2) {
    BorderSide borderSide = BorderSide(width: 0.8,color: Colors.grey[50]);
    return Padding(
      padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: borderSide,
                ),
              ),
              child: Image.network(model1.icon,width: MediaQuery.of(context).size.width * 0.5 - 10 - 0.8,),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: borderSide,
                  left:borderSide,
                ),
              ),
              child: Image.network(model2.icon,width: MediaQuery.of(context).size.width * 0.5 - 10-0.8,),
            ),
          ],
        ),
      );
  }



  Widget _topView(BuildContext context, CommonModel moreUrl) {
    topViewModel.url = widget.salesBoxModel.moreUrl;

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.network(widget.salesBoxModel.icon, width: 100, height: 40),
          Container(
            padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                colors: [Color(0xffff4e63), Color(0xffff6cc9)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FQWebView(commonModel: moreUrl);
                }));
              },
              child: Text(
                "获取更多福利 >",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
