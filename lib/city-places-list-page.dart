import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:tourism/city_model.dart';
import 'package:tourism/place-details-page.dart';

class CityPlacesPage extends StatefulWidget {
  const CityPlacesPage({Key? key, required this.title, required this.accessToken, required this.cityID}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String accessToken;
  final String title;
final String cityID;
  @override
  State<CityPlacesPage> createState() => _CityPlacesPageState();
}

class _CityPlacesPageState extends State<CityPlacesPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String password;
  late String username;
  final url='http://192.168.1.36:5000/rest/places';

  List<Place> places= [];
  late final response;
  Future<dynamic> getCities()async{
    String accessToken= widget.accessToken;
    String cityID= widget.cityID;
    Map data = {
      "city": cityID
    };
    //encode Map to JSON
    var body = json.encode(data);
    response= await http.post(Uri.parse(url), headers : {"Content-Type": "application/json","Authorization": "Bearer ${accessToken}"}, body: body);
    final jsonCities=json.decode(response.body.toString());
    places=List<Place>.from(
        json.decode(response.body)
            .map((data) => Place.fromJson(data))
    );






  }
  @override
  void initState()  {

    super.initState();
    getCities();
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:FutureBuilder(
            future: getCities(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

         if(places.isNotEmpty){
           return ListView(
           children:[

           for (Place e in places)
              GestureDetector(
               child: Card(
child: Column(
  children: [
    Container(
      height: 100,
      width:100,
      color: Colors.blue,
    ),
    Text(e.intro.toString())
  ],
),




             ),
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>  PlacePage(title: "Place Detail", full: e.full, alternative: e.alternative, landing: e.landing)),
               );
    },

              )]

           );

         }

          return  const CircularProgressIndicator();
        },

        )


      ),

    );
  }
}
