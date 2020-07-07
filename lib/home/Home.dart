import 'package:api/home/suggestion.dart';
import 'package:api/navigation/account.dart';
import 'package:api/navigation/save.dart';
import 'package:api/navigation/search.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'news.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 0;
  final pages = {HomeColumn(), SearchNav(), SaveNav(), AccountNav()};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "My",
              style: TextStyle(color: Colors.blue),
            ),
            Text("News")
          ],
        ),
      ),
      body: pages.elementAt(_page),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.search,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.bookmark_border,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            Icons.account_circle,
            size: 25,
            color: Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        height: 60,
        backgroundColor: Colors.white,
        color: Colors.grey[300],
        buttonBackgroundColor: Colors.grey[300],
      ),
    );
  }
}

class HomeColumn extends StatefulWidget {
  HomeColumn({Key key}) : super(key: key);

  @override
  _HomeColumnState createState() => _HomeColumnState();
}

class _HomeColumnState extends State<HomeColumn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            child: Suggestion(),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: Colors.white,
            width: 333,
            height: 511,
            child: News(),
          ),
        ],
      ),
    );
  }
}
