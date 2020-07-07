import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHelper extends StatefulWidget {
  final String newsurl;
  WebViewHelper({this.newsurl});

  @override
  _WebViewHelperState createState() => _WebViewHelperState(newsurl);
}

class _WebViewHelperState extends State<WebViewHelper> {
  String newsurl;
  _WebViewHelperState(this.newsurl);
  var isLoading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Web",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text("News")
                ],
              ),
            ),
            // body: Container(child: Center(child: Text("Raj"))),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: WebView(
                    onPageStarted: (_) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                    initialUrl: newsurl,
                    javascriptMode: JavascriptMode.unrestricted,
                  ),
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
              ],
            )));
  }
}
