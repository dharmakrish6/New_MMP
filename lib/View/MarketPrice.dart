import 'dart:developer';
import 'dart:math';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:mmp/Methods/post.dart';
import 'package:mmp/Services/ad_manager.dart';
import 'package:mmp/Services/service.dart';
import 'package:mmp/View/MarketList.dart';
import 'package:mmp/class/themeData.dart';
import 'package:flutter/material.dart';

class MarketPrice extends StatefulWidget {
  MarketPrice({Key? key}) : super(key: key);

  @override
  State<MarketPrice> createState() => _MarketPriceState();
}

runmarketPrice(context) {
  var marketName = ModalRoute.of(context)?.settings.arguments;
  print('market name ${marketName}');
  return marketName;
}

class _MarketPriceState extends State<MarketPrice> {
  List<Post> posts = [];
  List<Post> lstposts = [];
  List<Datum> lstDatum = [];
  late Post objPosts;
  var isLoaded = false;
  late InterstitialAd myInterstitial;
  @override
  void initState() {
    super.initState();
    myInterstitial = buildInterstitialAd()..load();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getData(runmarketPrice(context)));
  }

  Future<void> getData(market) async {
    objPosts = (await RomoteService().getPost(market));
    //method 1:
    print(objPosts.data[0].vegetableName);
    if (lstDatum != null) {
      setState(() {
        isLoaded = true;
        lstDatum = objPosts.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    showInterstitialAd();
    return Scaffold(
      appBar: AppBar(
        title: Text('Veg Wholesale price(1KG)'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Visibility(
          visible: isLoaded,
          replacement: Center(child: CircularProgressIndicator()),
          child: GridView.builder(
            itemCount: lstDatum.length,
            // ignore: prefer_const_constructors
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        Material(
                          color: Colors.teal[300],
                          child: InkWell(
                            onTap: () {
                              print('showing alert for other prices');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Expanded(
                                    child: AlertDialog(
                                      title: Text(lstDatum[index]
                                          .vegetableName
                                          .vegName()),
                                      content: Text(
                                        'Retail Prices: ₹${lstDatum[index].retailPrice} \nShopping Mall: ₹${lstDatum[index].shopingMallPrice}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "RobotoRegular",
                                        ),
                                      ),
                                      actions: [
                                        FlatButton(
                                          textColor: Colors.black,
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              child: const Text(
                                'Tap for more prices',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://vegetablemarketprice.com/' +
                                        lstDatum[index].table.imageUrl),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              lstDatum[index].vegetableName.vegName(),
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "RobotoRegular",
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: Color.fromARGB(255, 235, 5, 97),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '₹${lstDatum[index].price}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "RobotoBold",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
      ),
    );
  }

  InterstitialAd buildInterstitialAd() {
    return InterstitialAd(
      adUnitId: AdManager.interstitialAdUnitId,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          myInterstitial..load();
        } else if (event == MobileAdEvent.closed) {
          myInterstitial = buildInterstitialAd()..load();
        }
        print(event);
      },
    );
  }

  void showInterstitialAd() {
    myInterstitial..show();
  }

  void showRandomInterstitialAd() {
    Random r = new Random();
    bool value = r.nextBool();

    if (value == true) {
      myInterstitial..show();
    }
  }

  @override
  void dispose() {
    myInterstitial.dispose();
    super.dispose();
  }
}

extension MyExtension on String {
  String capi() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String vegName() {
    return "${this.split("(")[0]}";
  }
}
