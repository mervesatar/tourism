import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:tourism/city_model.dart';

class PlacePage extends StatefulWidget {
  const PlacePage({Key? key, required this.title, required this.full, required this.alternative,required this.landing}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String full;
  final String landing;
  final String title;
  final List<dynamic> alternative;
  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
int _index=0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String password;
  late String username;
  final url='http://192.168.43.46:5000/rest/places';
List<dynamic> links=[];

  @override
  void initState()  {
    links.add(widget.landing);
links.addAll(widget.alternative);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Tourism"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(

                        child:  Card(
                         child: Column(
                            children: [

                            SizedBox(
                            height: 200, // card height
                            child: PageView.builder(
    itemCount: widget.alternative.length+1,
    controller: PageController(viewportFraction: 0.7),
    onPageChanged: (int index) => setState(() => _index = index),
    itemBuilder: (_, i) {
    return Transform.scale(
    scale: i == _index ? 1 : 0.9,
    child: Card(
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Center(
    child: Image.network(
links[i].toString()
    ),
    ),
    ),
    );
    },
    ),
    ),

                              Text(widget.full.toString())

                            ],
                          )


                        ),






      ),

    );
  }
}
