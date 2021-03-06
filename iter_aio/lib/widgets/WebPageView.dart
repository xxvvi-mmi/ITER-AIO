//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'loading.dart';

// ignore: must_be_immutable
class WebPageView extends StatefulWidget {
  String link, title;
  WebPageView(this.title, this.link);

  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
//  Completer<WebViewController> _controller = Completer<WebViewController>();
  var loadingPage = true;

  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.link);
    return Scaffold(
      appBar: MediaQuery.of(context).orientation.index == 0
          ? AppBar(
              title: Text(widget.title),
              actions: <Widget>[
                IconButton(
                  icon: new Icon(Icons.open_in_browser),
                  onPressed: () {
                    _launchURL(widget.link);
                  },
                  tooltip: 'Open in Browser',
                ),
                // IconButton(
                //   icon: new Icon(Icons.feedback),
                //   onPressed: () {
                //     Wiredash.of(context).show();
                //   },
                // ),
              ],
              // elevation: 15,
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(25),
              //         bottomRight: Radius.circular(25))),
            )
          : null,
      body: widget.link == null
          ? Center(
              child: Text('Sorry No Data Found!'),
            )
          : IndexedStack(index: position, children: <Widget>[
              WebView(
                initialUrl: widget.link,
                javascriptMode: JavascriptMode.unrestricted,
                gestureNavigationEnabled: true,
                initialMediaPlaybackPolicy:
                    AutoMediaPlaybackPolicy.always_allow,
                // onWebViewCreated: (WebViewController webViewController) {
                //   _controller.complete(webViewController);
                //   });
                // },
                key: key,
                onPageFinished: doneLoading,
                onPageStarted: startLoading,
              ),
              Container(
                // color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(height: 200, child: loading()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: Text('Loading WebPage for you')),
                  ],
                ),
              ),
            ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  _launchURL(String url) async {
    // const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    return;
  }
}
