import 'package:api/home/webView.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SaveNav extends StatefulWidget {
  @override
  _SaveNavState createState() => _SaveNavState();
}

class _SaveNavState extends State<SaveNav> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: headlineBox.length,
            itemBuilder: (context, int index) {
              return Dismissible(
                key: new Key(headlineBox.getAt(index).toString()),
                onDismissed: (direction) {
                  headlineBox.deleteAt(index);
                  imageUrlBox.deleteAt(index);
                  urlBox.deleteAt(index);
                  showSnackBar();
                },
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WebViewHelper(
                          newsurl: urlBox.getAt(index).toString());
                    }));
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4.0),
                          height: 70,
                          width: MediaQuery.of(context).size.width / 5 - 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(imageUrlBox.getAt(index)),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          alignment: Alignment.topCenter,
                          width: ((MediaQuery.of(context).size.width * 4) / 5) -
                              18,
                          child: Text(
                            headlineBox.getAt(index).toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void showSnackBar() {
    final snackBar = new SnackBar(
      content: Text("Deleted"),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
