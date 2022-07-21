import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:tourism/city-places-list-page.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({Key? key, required this.title, required this.accessToken}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
final String accessToken;
  final String title;

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String password;
  late String username;
  final url='http://192.168.1.36:5000/rest/cities';
  List<dynamic> citiesList=[];
  Map<String,dynamic> citiesMap= new Map();
  late final response;
Future<dynamic> getCities()async{
  String accessToken= widget.accessToken;
  print(accessToken);
 response=await http.post(Uri.parse(url), headers : {"Authorization": "Bearer ${accessToken}"});
return response;


  }
  List<dynamic> myList= [];
  @override
  void initState()  {
    super.initState();
    getCities().then((value) {

      final jsonCities=json.decode(value.body.toString());
      citiesList= jsonCities["data"];
      citiesList.forEach((element) {print(element.toString());
      citiesMap.putIfAbsent(element["code"], () => element["name"]);
myList.add(element["name"]);

      });


    });


  }

  TextEditingController searchController = TextEditingController();

  void filterSearchResults(String query) {
    List<dynamic> dummyListData = [];
    List<dynamic> dummySearchList = [];
    dummySearchList.addAll(citiesMap.values);
    if (query.isNotEmpty) {
      dummySearchList.forEach((item) {
        if (item.toString().toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        myList.clear();
        myList.addAll(dummyListData);
      });
    } else if (query.isEmpty) {
      setState(() {
        myList.clear();
        myList.addAll(dummySearchList);
      });
    }
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
        title: Container(
          child: SizedBox(
            height: 44,
            width: 250,
            child: Form(

              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  filterSearchResults(value);
                },
                decoration: InputDecoration(
                    labelText: "Search",
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(13.0)),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(49, 76, 173, 1)),
                    )),
              ),
            ),
          )
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child:
            FutureBuilder(
              future: getCities(),
              builder: (context, snapshot) {
                if(myList.isNotEmpty){
                return
                  ListView.builder(
                      itemCount: myList.length,
                      itemBuilder: (BuildContext context, int index) {

                        return GestureDetector(
                          child: ListTile(
                              leading: const Icon(Icons.star),
                              title: Text(
                          citiesMap[citiesMap.keys.firstWhere(
                                  (k) => citiesMap[k] == myList[index].toString(), orElse: () => " ")],
                          style: TextStyle(color: Colors.redAccent, fontSize: 20)),
                          ),
onTap: (){

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  CityPlacesPage(title: "Cities",accessToken: widget.accessToken, cityID: citiesMap.keys.firstWhere(
            (k) => citiesMap[k] == myList[index].toString(), orElse: () => " "))),
  );

},
                        );
                      }
                      );



                }
                return const CircularProgressIndicator();
              }
            ),



    )
    );
  }
}
