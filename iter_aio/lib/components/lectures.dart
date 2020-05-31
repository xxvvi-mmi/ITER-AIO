import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:iteraio/components/videoPlayer.dart';
import 'package:wiredash/wiredash.dart';
// import 'MyHomePage.dart';

class Lectures extends StatefulWidget {
  String link, title;
  Lectures(this.title, this.link);
  @override
  _LecturesState createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {
  var isLoading;
  var lect;
  @override
  void initState() {
    setState(() {
      getLectures(widget.link);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 15,
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.feedback),
            onPressed: () {
              Wiredash.of(context).show();
            },
          ),
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    for (var i in lect)
                      ListTile(
                        enabled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        title: Text(
                          i['title'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        leading: Icon(Icons.play_circle_filled),
                        trailing: Text(
                          '${i['size']} MB',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        onTap: //null,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        // VideoApp(i['title'], i['link2'])
                                        WebPageVideo(i['title'], i['link2']))),
                        // subtitle: Text(DateTime.(i['date'])),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  getLectures(String url) async {
    setState(() {
      isLoading = true;
    });
    List<Map<String, dynamic>> linkMap2 = [];
    // var url = linkMap[0]['subjects'][0]['link'];
    var pageno = 0;
    var pagecount = 1;
    while (pagecount > pageno) {
      pageno++;
      final resp2 = await http
          .get('$url?page=$pageno&sortColumn=name&sortDirection=DESC');
      if (resp2.statusCode == 200) {
        var doc = parse(resp2.body);
        // print(doc.querySelector('html > body > script').text);
        var links2 = doc.querySelectorAll('html > body > script');
        var data1 = links2[links2.length - 1].text.substring(
            links2[links2.length - 1].text.indexOf('{'),
            links2[links2.length - 1].text.length - 1);
        var data2 = jsonDecode(data1).values.toList()[1];
        pageno = data2['pageNumber'];
        pagecount = data2['pageCount'];
        for (var i in data2['items']) {
          linkMap2.add({
            'title': i['name'],
            'id': i['id'],
            'link':
                'https://m.box.com/shared_item/${url.replaceAll('/', '%2F').replaceFirst(':', '%3A')}/view/${i['id']}',
            'link2':
                'https://m.box.com/${i['type']}/${i['id']}/${url.replaceAll('/', '%2F').replaceFirst(':', '%3A')}/preview/preview.mp4',
            'size': (i['itemSize'] / (1024 * 1024)).round(),
            'date': i['date'],
            'imageurl': i['thumbnailURLs']['large'],
            'preview': i['thumbnailURLs']['preview'],
          });
        }
      }
    }
    setState(() {
      isLoading = false;
    });
    lect = linkMap2;
    // print(linkMap2[0]);
  }
}
