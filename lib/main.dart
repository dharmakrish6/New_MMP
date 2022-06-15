import 'package:mmp/View/MarketList.dart';
import 'package:mmp/View/MarketPrice.dart';
import 'package:mmp/View/UlavarSanthai.dart';
import 'package:mmp/View/UlavarSanthai2.dart';
import 'package:mmp/class/themeData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../Services/ad_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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

  FirebaseAdMob.instance.initialize(appId: AdManager.appId);

  createBannerAd()
    ..load()
    ..show();

  runApp(MyApp());
  // FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'காய்கறி விலை நிலவரம்',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "RobotoRegular",
                ),
              ),
              bottom: TabBar(
                tabs: [Tab(text: "மார்க்கெட்"), Tab(text: "உழவர் சந்தை")],
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Share.share(
                        'Checkout Kaikari-Vegigetable Price|Calories|Vitamins Applications\n https://play.google.com/store/apps/details?id=com.futureappz.mmp');
                  },
                ),
              ],
            ),
            body: TabBarView(
              children: [
                MarketList(),
                WebViewStack(),
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
