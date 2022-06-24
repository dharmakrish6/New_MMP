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
  String result1 = 'Live Gold Rate';
  String result2 = 'Tap below button to get latest price per gram';
  String result3 = '';
  String result4 = '';
  String result5 = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // if isLoading is true show loader
            // else show Column of Texts

            isLoading
                ? CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result1,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(result2,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(result3,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(result4,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(result5,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            MaterialButton(
              minWidth: 200,
              height: 55,
              onPressed: () async {
                // Setting isLoading true to show the loader
                setState(() {
                  isLoading = true;
                });

                // Awaiting for web scraping function
                // to return list of strings
                final response = await extractData();

                // Setting the received strings to be
                // displayed and making isLoading false
                // to hide the loader
                setState(() {
                  result1 = response[0].replaceAll('- ₹', ': ₹');
                  result2 =
                      "${response[1].replaceAll('- ₹', ': ₹')} -( 1 பவுன் : ${int.parse(response[1].split('₹')[1]) * 8})";
                  result3 = response[2].replaceAll('- ₹', ': ₹');
                  result4 = response[3].replaceAll('- ₹', ': ₹');
                  result5 = response[4].replaceAll('- ₹', ': ₹');
                  isLoading = false;
                });
              },
              child: Text(
                'Get today Rate',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.green,
            )
          ],
        )),
      ),
    );
  }
}
