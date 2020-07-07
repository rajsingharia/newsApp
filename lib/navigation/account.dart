import 'package:flutter/material.dart';

class AccountNav extends StatefulWidget {
  AccountNav({Key key}) : super(key: key);

  @override
  _AccountNavState createState() => _AccountNavState();
}

class _AccountNavState extends State<AccountNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Center(child: Text("Account")),
      ),
    );
  }
}
