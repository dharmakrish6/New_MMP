import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class LPGPrice extends StatelessWidget {
  LPGPrice({Key? key}) : super(key: key);

  final myProducts = [
    'Ariyalur',
    'Chennai',
    'Coimbatore',
    'Cuddalore',
    'Dharmapuri',
    'Dindigul',
    'Erode',
    'Kanchipuram',
    'Karur',
    'Madurai',
    'Nagapattinam',
    'Nagercoil',
    'Namakkal',
    'Ooty',
    'Perambalur',
    'Pudukkottai',
    'Ramanathapuram',
    'Salem',
    'Sivaganga',
    'Thanjavur',
    'Theni',
    'Thiruvallur',
    'Tiruchirappalli',
    'Tirunelveli',
    'Tiruppur',
    'Tiruvannamalai',
    'Tiruvarur',
    'Vellore',
    'Viluppuram',
    'Virudhunagar'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView.builder(
          itemCount: myProducts.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Color.fromARGB(255, 171, 246, 80),
              elevation: 10,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                ListTile(
                  leading: Icon(Icons.album, size: 60),
                  title:
                      Text(myProducts[index], style: TextStyle(fontSize: 30.0)),
                  subtitle: Text('₹ 1041', style: TextStyle(fontSize: 18.0)),
                ),
              ]),
            );
          }),
    ));
  }
}
