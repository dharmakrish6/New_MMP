import 'dart:developer';

import 'package:mmp/Methods/post.dart';
import 'package:mmp/Services/service.dart';
import 'package:mmp/class/themeData.dart';
import 'package:flutter/material.dart';

class MMP extends StatefulWidget {
  MMP({Key? key}) : super(key: key);

  @override
  State<MMP> createState() => _MMPState();
}

class _MMPState extends State<MMP> {
  List<Post> posts = [];
  List<Post> lstposts = [];
  List<Datum> lstDatum = [];
  late Post objPosts;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    objPosts = (await RomoteService().getPost());
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
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Veg Wholesale price'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Visibility(
            visible: isLoaded,
            replacement: Center(child: CircularProgressIndicator()),
            child: GridView.builder(
              itemCount: lstDatum.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
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
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "NotoSerifTamil",
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
                                  'Price  \₹${lstDatum[index].price}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
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

extension MyExtension on String {
  String capi() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String vegName() {
    return "${this.split("(")[0]}";
  }
}
