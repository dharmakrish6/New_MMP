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

List<List> markets = [
  ["chennai", "சென்னை"],
  ["koyambedu", "கோயம்பேடு"],
  ["hosur", "ஓசூர்"],
  ["coimbatore", "கோவை"],
  ["bangalore", "பெங்களூர்"],
  ["dharmapuri", "தர்மபுரி"],
  ["cuddalore", "கடலூர்"],
  ["chengalpattu", "செங்கல்பட்டு"],
  ["dindigul", "திண்டுக்கல்"],
  ["erode", "ஈரோடு"],
  ["ariyalur", "அரியாலூர்"],
  ["kallakurichi", "கள்ளக்குறிச்சி"],
  ["kanchipuram", "காஞ்சிபுரம்"],
  ["karur", "கரூர்"],
  ["krishnagiri", "கிருஷ்ணகிரி"],
  ["madurai", "மதுரை"],
  ["mayiladuthurai", "மயிலாடுதுறை"],
  ["nagapattinam", "நாகப்பட்டிணம்"],
  ["nagercoil", "நகர்க்கோவில்"],
  ["namakkal", "நாமக்கல்"],
  ["perambalur", "பெரம்பலூர்"],
  ["pudukkottai", "புதுக்கோட்டை"],
  ["ramanathapuram", "ராமநாதபுரம்"],
  ["ranipet", "ராணிப்பேட்டை"],
  ["salem", "சேலம்"],
  ["sivaganga", "சிவகங்கை"],
  ["tenkasi", "தென்காசி"],
  ["thanjavur", "தஞ்சாவூர்"],
  ["theni", "தேனி"],
  ["thoothukudi", "தூத்துகுடி"],
  ["tiruchirappalli", "திருச்சி"],
  ["tirunelveli", "திருநெல்வேலி"],
  ["tirupattur", "திருப்பத்தர்"],
  ["tirupur", "திருப்பூர்"],
  ["tiruvallur", "திருவள்ளூர்"],
  ["tiruvannamalai", "திருவண்ணாமலை"],
  ["tiruvarur", "திருவாரூர்"],
  ["udagamandalam", "உதகமண்டலம்"],
  ["vellore", "வேலூர்"],
  ["viluppuram", "விழுப்புரம்"],
  ["thiruvananthapuram", "திருவனந்தபுரம்"],
  ["ernakulam", "எர்னகுளம்"],
  ["kozhikode", "கோழிக்கோடு"],
  ["palakkad", "பாலக்காடு"],
  ["kollam", "கொல்லம்"],
  ["visakhapatnam", "விசாகப்பட்டனம்"],
  ["hyderabad", "ஹைதராபாத்"]
];

class _MarketListState extends State<MarketList> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 40.0),
          itemCount: markets.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                  onTap: () {
                    //Passing data to other screen while navigate
                    Navigator.of(context)
                        .pushNamed('marketPrice', arguments: markets[index][0]);
                  },
                  leading: Icon(
                    Icons.local_shipping_outlined,
                    color: Colors.green,
                  ),
                  title: Text(
                    markets[index][1] + " மார்க்கெட்",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "RobotoRegular",
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                  )),
            );
          },
        ),
      );
}
