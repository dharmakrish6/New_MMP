import 'dart:developer';

import 'package:mmp/Services/service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RomoteService {
  late Post objPost;
  // Future<List<Datum>?> getposts() async {
  //   List<Datum> lstofPost = [];
  //   var client = http.Client();
  //   var uri = Uri.parse(
  //       'https://vegetablemarketprice.com/api/data/market/dharmapuri/daywise?date=2022-05-24');
  //   var respons = await client.get(uri);
  //   if (respons.statusCode == 200) {
  //     var json = respons.body;
  //     lstofPost.add(datumFromJson(json));
  //     return lstofPost;
  //   } else
  //     return null;
  // }

  Future<Post> getPost(market) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    var client = http.Client();
    var uri = Uri.parse(
        'https://vegetablemarketprice.com/api/data/market/${market}/daywise?date=2022-05-30');
    var response = await client.get(uri);
    print(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      objPost = postFromJson(json);
      return objPost;
    } else {
      return objPost;
    }
  }
}
