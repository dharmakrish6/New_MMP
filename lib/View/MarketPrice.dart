import 'dart:developer';
import 'dart:math';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:mmp/Methods/post.dart';
import 'package:mmp/Services/ad_manager.dart';
import 'package:mmp/Services/service.dart';
import 'package:mmp/View/MarketList.dart';
import 'package:mmp/class/themeData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

List<String> calories = [
  "40",
  "32",
  "18",
  "40",
  "43",
  "77",
  "89",
  "23",
  "48",
  "13",
  "26",
  "23",
  "40",
  "34",
  "15",
  "115",
  "88",
  "25",
  "41",
  "25",
  "31",
  "354",
  "42",
  "88",
  "4",
  "365",
  "16",
  "108",
  "43",
  "172",
  "25",
  "25",
  "118",
  "49",
  "31",
  "149",
  "80",
  "32",
  "81",
  "21",
  "29",
  "60",
  "70",
  "22",
  "27",
  "22",
  "26",
  "16",
  "20",
  "44",
  "86",
  "22",
  "23",
  "86"
];
List<String> vitamins = [
  "Manganese,Vitamin B6,Vitamin C",
  "Manganese,Vitamin B6,Vitamin C",
  "Folate, vitamin C, and potassium",
  "Vitamins A, B6, and C, antioxidants, calcium, zinc, and iron",
  "Fiber, folate (vitamin B9), manganese, potassium, iron, and vitamin C.",
  "Calcium, Magnesium, and Folate",
  "Vitamin C and Vitamin B6",
  "Vitamin A, Vitamin C, Vitamin B6 and B9, Riboflavin, Niacin, Calcium, Omega 3 fatty acids, Iron, Phosphorous, Magnesium, Zinc, Sodium, Potassium, Copper, Manganese and many essential minerals and nutrients",
  "Vitamin C, Vitamin E, Vitamin A",
  "Vitamin C",
  "Vitamin A, B, C and E and as well as folate, thiamin and pantothenic",
  "Potassium, calcium, as well as vitamins A, C, and E",
  "Vitamin C, Vitamin A, Vitamin B6 and folate",
  "Vitamin A,Vitamin C,Calcium,Iron,Thiamine (B1),Riboflavin (B2),Niacin (B3),Folic Acid (B9),Potassium,Zinc,Phosphorus,Magnesium",
  "Vitamin C, Vitamin B, Vitamin K, Vitamin A, Vitamin E, Iron, Folate, Magnesium, and Potassium.",
  "Potassium, magnesium, folate, iron, and zinc",
  "Vitamins A and C, Potassium and Iron",
  "calcium, iron, vitamin A, vitamin C, K, potassium, folate",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Will be added soon",
  "Vitamin A, Vitamin C, Vitamin K, iron, folate, and potassium",
  "B vitamins.,Vitamin C.,Calcium.,Iron.,Magnesium.,Phosphorus.,Potassium.,Thiamin."
];

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
  // List<Post> posts = [];
  // List<Post> lstposts = [];
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

  void showAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(message),
              actions: [
                FlatButton(
                  textColor: Colors.black,
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('OK'),
                ),
              ],
            ));
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
    // showInterstitialAd();
    // showAlert(context, "Tap on Vegetables to get more price !");
    // Fluttertoast.showToast(
    //     msg: "Tap on vegetables to know \nother price details!",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.amber[900],
    //     textColor: Colors.white,
    //     fontSize: 16.0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetable price - per 1KG'),
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
                crossAxisCount: 2, mainAxisSpacing: 1, crossAxisSpacing: 1),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        InkWell(
                          // Padding(
                          //   padding: const EdgeInsets.all(30),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://vegetablemarketprice.com/' +
                                        lstDatum[index].table.imageUrl),
                              ),
                            ),
                          ),
                          onTap: () {
                            print('showing alert for other prices');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  child: AlertDialog(
                                    backgroundColor:
                                        Color.fromARGB(255, 232, 238, 238),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    title: Text(
                                      lstDatum[index].vegetableName.vegName(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      'Retail Prices: ₹ ${lstDatum[index].retailPrice} \nWholesale Price: ₹ ${lstDatum[index].price}\n\nCalories:\n${calories[index]} cal/100g\n\nVitamins:\n${vitamins[index]}',
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
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              '${lstDatum[index].vegetableName.vegName()}',
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
                                '₹${lstDatum[index].shopingMallPrice}',
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
