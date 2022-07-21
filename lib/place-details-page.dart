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

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String password;
  late String username;
  final url='http://192.168.43.46:5000/rest/places';

  @override
  void initState()  {

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
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.landing.toString()))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  widget.full.toString(),
                                  style: TextStyle(color: Colors.black, fontSize: 15)),
                            ),
                          ),
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
                        ),






      ),

    );
  }
}
