import 'package:dmp/View/Screen1.dart';
import 'package:dmp/class/themeData.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Screen1(),
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Themedata.sbackground,
        ),
      );
}
