import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:tourism/cities-list-page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
late String password;
late String username;
late String accessToken;
final url='http://192.168.1.36:5000/rest/login';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              height:100,
              width:200,

              child: const Text("Login Page",style: TextStyle(color: Colors.redAccent,fontSize: 35,),textAlign: TextAlign.center,),
            ),
             Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.redAccent)
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.redAccent),
                    hintText: 'Enter your secure password'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                password=passwordController.text;
                username=usernameController.text;

                Map data = {
                  "username": username,
                  "password": password
                };
                //encode Map to JSON
                var body = json.encode(data);

                final response= await http.post(Uri.parse(url),body:body,headers: {"Content-Type": "application/json"},);
                if(response.statusCode.toString()=="200"){

                 accessToken=json.decode(response.body.toString())['access_token'].toString();
                  EasyLoading.showSuccess('Succesfully logged in!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  CitiesPage(title: "Cities",accessToken: accessToken)),
                  );
                }
                else
                EasyLoading.showError('Please enter correct username and password!');

              },
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
