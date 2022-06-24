import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class GoldPrice extends StatefulWidget {
  GoldPrice({Key? key}) : super(key: key);

  @override
  State<GoldPrice> createState() => _GoldPriceState();
}

class _GoldPriceState extends State<GoldPrice> {
// Strings to store the extracted Article titles
  List data = ["Loading..", "Loading..", "Loading..", "Loading..", "Loading.."];
  List _datafromList = [];
  late Future<List> response;

// boolean to show CircularProgressIndication
// while Web Scraping awaits
  bool isLoading = false;

  Future<List<String>> extractData() async {
    // Getting the response from the targeted url
    final response =
        await http.Client().get(Uri.parse('https://www.oriana.com/'));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {
      // Getting the html document from the response
      var document = parser.parse(response.body);
      try {
        // Scraping the first article title
        var responseString1 = document
            .getElementsByClassName('header')[0]
            .getElementsByClassName('todays_rate')[0]
            .getElementsByClassName('state_rates')[0]
            .getElementsByTagName('li')[0];

        print(responseString1.text.trim());

        // Scraping the second article title
        var responseString2 = document
            .getElementsByClassName('header')[0]
            .getElementsByClassName('todays_rate')[0]
            .getElementsByClassName('state_rates')[0]
            .getElementsByTagName('li')[1];

        print(responseString2.text.trim());

        // Scraping the third article title
        var responseString3 = document
            .getElementsByClassName('header')[0]
            .getElementsByClassName('todays_rate')[0]
            .getElementsByClassName('state_rates')[0]
            .getElementsByTagName('li')[2];

        print(responseString3.text.trim());

        var responseString4 = document
            .getElementsByClassName('header')[0]
            .getElementsByClassName('todays_rate')[0]
            .getElementsByClassName('state_rates')[0]
            .getElementsByTagName('li')[3];

        print(responseString4.text.trim());

        var responseString5 = document
            .getElementsByClassName('header')[0]
            .getElementsByClassName('todays_rate')[0]
            .getElementsByClassName('state_rates')[0]
            .getElementsByTagName('li')[4];

        print(responseString5.text.trim());

        // Converting the extracted titles into
        // string and returning a list of Strings
        return [
          responseString1.text.trim(),
          responseString2.text.trim(),
          responseString3.text.trim(),
          responseString4.text.trim(),
          responseString5.text.trim()
        ];
      } catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }

  _GoldPriceState() {
    extractData().then((val) => setState(() {
          _datafromList = val;
        }));
  }
  List items = [
    "தங்கம்(24K)- 1கிராம்",
    "தங்கம்(22K)- 1கிராம்",
    "தங்கம்(18K)- 1கிராம்",
    "பிளாட்டினம்- 1கிராம்",
    "சில்வர்- 1கிராம்"
  ];

  List images = [
    'https://www.freeiconspng.com/thumbs/gold-bar-png/gold-bars-png-4.png',
    'https://savoryjewellery.com/wp-content/uploads/2018/05/SJCB04-995-Purity-Gold-Coin-1-Gm.jpg',
    'https://cdn.caratlane.com/media/catalog/product/G/C/GC00004-4Y0000_1_lar.jpg',
    'https://pngimage.net/wp-content/uploads/2018/06/platino-png-5.png',
    'https://m.media-amazon.com/images/I/71Be81rGzPL._UY500_.jpg'
  ];

  Widget _myListView(BuildContext context) {
    final response = _datafromList;
    setState(() {
      if (response.isNotEmpty) {
        data[0] = response[0].split('₹')[1];
        data[1] = response[1].split('₹')[1];
        data[2] = response[2].split('₹')[1];
        data[3] = response[3].split('₹')[1];
        data[4] = response[4].split('₹')[1];
        isLoading = false;
      } else {
        setState(() {
          isLoading = !isLoading;
        });
      }
    });
    var sequenceNumbers = new List<int>.generate(20, (k) => k + 1);
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 40.0),
      itemCount: items.length,
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
                            image: NetworkImage(images[index]),
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.blue),
                        child: Text(
                          '${items[index]}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "RobotoRegular"),
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
                          '₹${data[index]}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return _myListView(context);
  }
}
