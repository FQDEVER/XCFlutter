
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:xiecheng_app/model/common_model.dart';

class FQWebView extends StatelessWidget {

  final CommonModel commonModel;
  FQWebView({Key key,this.commonModel}):super(key : key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    print("--------------${statusBarHeight}");
    return Material(
      color: commonModel.statusBarColor == null ? Colors.white : Color(int.parse("0xfff${commonModel.statusBarColor}")),
      child: SafeArea(
          child: SizedBox.expand(
        child: WebView(
                initialUrl: commonModel.url,
                javascriptMode: JavascriptMode.unrestricted,
         ),
      ),
      bottom: false,
      ),
    );
  }
}