import 'package:dmp/View/Screen2.dart';
import 'package:dmp/class/themeData.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: _endDrawer(),
        appBar: AppBar(
          title: Text(
            Themedata.maintitle,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MMP()));
                },
                title: Text('Dis'),
              ),
            );
          },
        ),
      );
}

class _endDrawer extends StatelessWidget {
  const _endDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer();
}
