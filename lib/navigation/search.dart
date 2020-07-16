import 'dart:convert';
import 'package:api/home/webView.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class SearchNav extends StatefulWidget {
  @override
  _SearchNavState createState() => _SearchNavState();
}

TextEditingController _textEditingController = new TextEditingController();
String s;
bool serached = false;

class _SearchNavState extends State<SearchNav> {
  List data;
  Box<String> headlineBox;
  Box<String> imageUrlBox;
  Box<String> urlBox;

  @override
  void initState() {
    super.initState();
    headlineBox = Hive.box<String>("Headline");
    imageUrlBox = Hive.box<String>("ImageUrl");
    urlBox = Hive.box<String>("Url");
  }

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
                    if (_textEditingController.text.isEmpty)
                      setState(() {
                        serached = false;
                      });
                    else {
                      setState(() {
                        serached = true;
                        s = _textEditingController.text;
                        final String url =
                            "http://newsapi.org/v2/everything?q=$s&sortBy=publishedAt&apiKey=69211d3827464206986d9d162bc247e0";
                        getData(url);
                      });
                    }
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
                      padding: EdgeInsets.all(50),
                      color: Colors.white,
                      height: 510,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/up.gif",
                          height: 80,
                          width: 80,
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
                                  onLongPress: () {
                                    showSnackBar();
                                    headlineBox.put(data[index]["title"],
                                        data[index]["title"].toString());

                                    imageUrlBox.put(data[index]["urlToImage"],
                                        data[index]["urlToImage"].toString());

                                    urlBox.put(data[index]["url"],
                                        data[index]["url"].toString());
                                  },
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

  void showSnackBar() {
    final snackBar = new SnackBar(
      content: Text("Saved"),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
