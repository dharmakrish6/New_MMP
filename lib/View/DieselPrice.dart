import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import '../../Services/ad_manager.dart';

class DieselPrice extends StatefulWidget {
  DieselPrice({Key? key}) : super(key: key);

  @override
  State<DieselPrice> createState() => _DieselPriceState();
}

class _DieselPriceState extends State<DieselPrice> {
// Strings to store the extracted Article titles
  var district_name = [
    "அரியாலூர்",
    "சென்னை",
    "கோவை",
    "கடலூர்",
    "தர்மபுரி",
    "திண்டுக்கல்",
    "ஈரோடு",
    "காஞ்சிபுரம்",
    "கரூர்",
    "மதுரை",
    "நாகப்பட்டிணம்",
    "நகர்க்கோவில்",
    "நாமக்கல்",
    "ஊட்டி ",
    "பெரம்பலூர்",
    "புதுக்கோட்டை",
    "ராமநாதபுரம்",
    "சேலம்",
    "சிவகங்கை",
    "தஞ்சாவூர்",
    "தேனி",
    "திருவள்ளூர்",
    "தூத்துக்குடி",
    "திருச்சி",
    "திருநெல்வேலி",
    "திருப்பூர்",
    "திருவண்ணாமலை",
    "திருவாரூர்",
    "வேலூர்",
    "விழுப்புரம் ",
    "விருதுநகர்"
  ];
  List data = [
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching..",
    "fetching.."
  ];

  List _datafromList = [];

  late Future<List> response;

// boolean to show CircularProgressIndication
// while Web Scraping awaits
  bool isLoading = false;

  Future<List> extractData() async {
    // Getting the response from the targeted url
    final response = await http.Client().get(Uri.parse(
        'https://www.mypetrolprice.com/diesel-price-in-india.aspx?stateId=33'));

    // Status Code 200 means response has been received successfully
    if (response.statusCode == 200) {
      // Getting the html document from the response
      var document = parser.parse(response.body);
      try {
        // Scraping the first article title
        List links = document.querySelectorAll('div.SF div.txtC>b');
        List linkMap = [];
        for (var link in links) {
          linkMap.add(link.text);
        }

        print(linkMap);

        return linkMap;
      } catch (e) {
        return ['', '', 'ERROR!'];
      }
    } else {
      return ['', '', 'ERROR: ${response.statusCode}.'];
    }
  }

  _DieselPriceState() {
    extractData().then((val) => setState(() {
          _datafromList = val;
        }));
  }

  Widget _myListView(BuildContext context) {
    if (_datafromList.isEmpty) {
      setState(() {
        isLoading = true;
        Text("Please wait .....!");
      });
    } else {
      setState(() {
        data = _datafromList;
        isLoading = false;
      });
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 40.0),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
              leading: Icon(
                Icons.location_on_rounded,
                color: Colors.green,
              ),
              title: Text(
                district_name[index],
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "RobotoRegular",
                ),
              ),
              trailing: new Text(
                data[index],
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
