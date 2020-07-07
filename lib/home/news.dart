import 'dart:convert';
import 'package:api/home/webView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  String url =
      "http://newsapi.org/v2/top-headlines?country=in&apiKey=69211d3827464206986d9d162bc247e0";
  List data;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var response = await http.get(Uri.encodeFull(url));
    var extractdata = jsonDecode(response.body);
    data = extractdata["articles"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: data != null
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () {
                    String url = data[index]["url"];
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WebViewHelper(newsurl: url);
                    }));
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300]),
                      width: 330,
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: data[index]["urlToImage"]
                                                  .toString() !=
                                              "null"
                                          ? NetworkImage(
                                              data[index]["urlToImage"])
                                          : NetworkImage(
                                              "https://cdn4.wpbeginner.com/wp-content/uploads/2013/04/wp404error.jpg"),
                                      fit: BoxFit.cover),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data[index]["title"].toString() != "null"
                                  ? data[index]["title"]
                                  : "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              data[index]["description"].toString() != "null"
                                  ? data[index]["description"]
                                  : "",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
