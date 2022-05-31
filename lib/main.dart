import 'package:mmp/View/MarketList.dart';
import 'package:mmp/View/MarketPrice.dart';
import 'package:mmp/class/themeData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../Services/ad_manager.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  FirebaseAdMob.instance.initialize(appId: AdManager.appId);

  createBannerAd()
    ..load()
    ..show();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MarketList(),
        routes: {
          "marketPrice": (context) => MarketPrice(),
        },
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Themedata.sbackground,
        ),
      );
}
