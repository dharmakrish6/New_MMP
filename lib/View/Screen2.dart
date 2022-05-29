import 'package:dmp/Methods/post.dart';
import 'package:dmp/Services/service.dart';
import 'package:dmp/class/themeData.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

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
  var isLoaed = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    objPosts = (await RomoteService().getPost());
    //method 1:

    if (lstDatum != null) {
      setState(() {
        isLoaed = true;
        lstDatum = objPosts.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Vagitables'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Visibility(
            visible: isLoaed,
            replacement: Center(child: CircularProgressIndicator()),
            child: GridView.builder(
              itemCount: lstDatum.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, mainAxisSpacing: 8, crossAxisSpacing: 8),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                lstDatum[index].id.capi(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                                color: Colors.amber,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Price  \$${lstDatum[index].price}',
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
}
