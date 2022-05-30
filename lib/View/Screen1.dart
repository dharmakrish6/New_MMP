import 'package:mmp/View/Screen2.dart';
import 'package:mmp/class/themeData.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

List<String> markets = [
  "ariyalur",
  "chengalpattu",
  "chennai",
  "coimbatore",
  "cuddalore",
  "dharmapuri",
  "dindigul",
  "erode",
  "hosur",
  "kallakurichi",
  "kanchipuram",
  "karur",
  "koyambedu",
  "krishnagiri",
  "madurai",
  "mayiladuthurai",
  "nagapattinam",
  "nagercoil",
  "namakkal",
  "perambalur",
  "pudukkottai",
  "ramanathapuram",
  "ranipet",
  "salem",
  "sivaganga",
  "tenkasi",
  "thanjavur",
  "theni",
  "thoothukudi",
  "tiruchirappalli",
  "tirunelveli",
  "tirupattur",
  "tirupur",
  "tiruvallur",
  "tiruvannamalai",
  "tiruvarur",
  "udagamandalam",
  "vellore",
  "viluppuram"
];

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
          itemCount: 25,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MMP()));
                  },
                  leading: Icon(
                    Icons.storefront_outlined,
                    color: Colors.green,
                  ),
                  title: Text(markets[index].capi() + " Market Price"),
                  trailing: Icon(
                    Icons.arrow_right,
                  )),
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
