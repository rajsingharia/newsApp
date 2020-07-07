import 'dart:convert';
import 'package:api/home/webView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchNav extends StatefulWidget {
  @override
  _SearchNavState createState() => _SearchNavState();
}

TextEditingController _textEditingController = new TextEditingController();
String s;
bool serached = false;

class _SearchNavState extends State<SearchNav> {
  @override
  List data;
  getData(String url) async {
    var response = await http.get(Uri.encodeFull(url));
    var extractdata = jsonDecode(response.body);
    data = extractdata["articles"];
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              ListTile(
                title: TextField(
                  decoration: InputDecoration(hintText: "What's in your mind"),
                  controller: _textEditingController,
                  onChanged: (text) {
                    if (_textEditingController.text == "")
                      setState(() {
                        serached = false;
                      });
                    setState(() {
                      serached = true;
                      s = _textEditingController.text;
                      String url =
                          "http://newsapi.org/v2/everything?q=$s&sortBy=publishedAt&apiKey=69211d3827464206986d9d162bc247e0";

                      getData(url);
                    });
                  },
                ),
                trailing: SizedBox(
                  height: 20,
                  width: 30,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _textEditingController.text = "";
                        serached = false;
                      });
                    },
                    child: Icon(Icons.cancel),
                  ),
                ),
              ),
              serached != true
                  ? Container(
                      height: 510,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Nothing To Show",
                        ),
                      ),
                    )
                  : Container(
                      height: 510,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[300]),
                                      width: 330,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                                height: 220,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: data[index][
                                                                      "urlToImage"]
                                                                  .toString() !=
                                                              "null"
                                                          ? NetworkImage(data[
                                                                  index]
                                                              ["urlToImage"])
                                                          : NetworkImage(
                                                              "https://cdn4.wpbeginner.com/wp-content/uploads/2013/04/wp404error.jpg"),
                                                      fit: BoxFit.cover),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              data[index]["title"].toString() !=
                                                      "null"
                                                  ? data[index]["title"]
                                                  : "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              data[index]["description"]
                                                          .toString() !=
                                                      "null"
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
                    ),
            ],
          )),
    );
  }
}
