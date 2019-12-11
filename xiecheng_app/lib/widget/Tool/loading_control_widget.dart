
import 'package:flutter/material.dart';


class LoadingControl extends StatelessWidget {

  final Widget child;
  final bool isloading;
  final bool cover;

  LoadingControl({
    Key key,
    @required this.child,
    @required this.isloading,
    this.cover = false //是否有遮罩.默认为false.即分开处理.如果为true.则加载进度在子视图上
   }):super(key : key);

  @override
  Widget build(BuildContext context) {
    return cover ? _stackView : (isloading ? _loadingView : child);
  }
  Widget get _stackView{
    return Stack(
      children: <Widget>[
        child,
        isloading ? _loadingView : Text(""),
      ],
    );
  }

  Widget get _loadingView{
    return Container(
      color: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.orange,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
