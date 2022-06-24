import 'package:mmp/View/DieselPrice.dart';
import 'package:mmp/View/GoldPrice.dart';
import 'package:mmp/View/LPGPrice.dart';
import 'package:mmp/View/MarketList.dart';
import 'package:mmp/View/MarketPrice.dart';
import 'package:mmp/View/PetrolPrice.dart';
import 'package:mmp/View/UlavarSanthai.dart';
import 'package:mmp/class/themeData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../Services/ad_manager.dart';
import 'package:share_plus/share_plus.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  FirebaseAdMob.instance.initialize(appId: AdManager.appId);

  createBannerAd()
    ..load()
    ..show();

  await Future.delayed(const Duration(milliseconds: 500));

  runApp(MyApp());

  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new DefaultTabController(
          length: 6,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'தினசரி விலை நிலவரம்',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "RobotoRegular",
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                      text: "மார்க்கெட்",
                      icon: new Icon(Icons.local_convenience_store_rounded)),
                  Tab(text: "உழவர் சந்தை", icon: new Icon(Icons.store)),
                  Tab(
                      text: "தங்கம்",
                      icon: new Icon(Icons.monetization_on_outlined)),
                  Tab(
                      text: "சமையல் எரிவாயு",
                      icon: new Icon(Icons.gas_meter_sharp)),
                  Tab(
                      text: "பெட்ரோல்",
                      icon: new Icon(Icons.two_wheeler_sharp)),
                  Tab(
                      text: "டீசல்",
                      icon: new Icon(Icons.local_shipping_outlined)),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Share.share(
                        'Checkout Kaikari-Vegetable,Gold,LPG,Petrol and Diesel Price of daily price changes \n https://play.google.com/store/apps/details?id=com.futureappz.mmp');
                  },
                ),
              ],
            ),
            body: TabBarView(
              children: [
                MarketList(),
                WebViewStack(),
                GoldPrice(),
                LPGPrice(),
                PetrolPrice(),
                DieselPrice(),
              ],
            ),
          ),
        ),
        routes: {
          "marketPrice": (context) => MarketPrice(),
        },
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Themedata.sbackground,
        ),
      );
}
