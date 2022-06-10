// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:firebase_admob/firebase_admob.dart';
import 'package:mmp/View/MarketPrice.dart';
import 'package:mmp/class/themeData.dart';
import 'package:flutter/material.dart';
import '../Services/ad_manager.dart';

class MarketList extends StatefulWidget {
  MarketList({Key? key}) : super(key: key);

  @override
  State<MarketList> createState() => _MarketListState();
}

Future<void> _initAdMob() {
  // TODO: Initialize AdMob SDK
  return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
}

List<String> markets = [
  "chennai",
  "koyambedu",
  "hosur",
  "coimbatore",
  "bangalore",
  "dharmapuri",
  "cuddalore",
  "chengalpattu",
  "dindigul",
  "erode",
  "ariyalur",
  "kallakurichi",
  "kanchipuram",
  "karur",
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
  "viluppuram",
  "thiruvananthapuram",
  "ernakulam",
  "kozhikode",
  "palakkad",
  "kollam",
  "visakhapatnam",
  "hyderabad"
];

class _MarketListState extends State<MarketList> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          itemCount: markets.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                  onTap: () {
                    //Passing data to other screen while navigate
                    Navigator.of(context)
                        .pushNamed('marketPrice', arguments: markets[index]);
                  },
                  leading: Icon(
                    Icons.storefront_outlined,
                    color: Colors.green,
                  ),
                  title: Text(
                    markets[index].capi() + " Market Price",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "RobotoRegular",
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_right,
                  )),
            );
          },
        ),
      );
}
