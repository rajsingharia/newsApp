import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'home/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("Headline");
  await Hive.openBox<String>("ImageUrl");
  await Hive.openBox<String>("Url");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Box<String> headlineBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    headlineBox = Hive.box<String>("Headline");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      title: "Api Practice",
      home: Home(),
    );
  }
}
