import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SharedPreferences? prefs;
  String? name;
  String? pass;

  @override
  void initState() {
    nextPage();
    super.initState();
  }

  Widget page = LoginPage();

  void nextPage()async{
    prefs =await SharedPreferences.getInstance();
    name = prefs!.getString('name');
    pass = prefs!.getString('pass');

    if(name != null && name != "" && pass != null && pass != ""){
      page = HomeScreen();
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return page;
      }));
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width:  double.infinity,
        color: Colors.greenAccent,
        child: Center(
          child: SizedBox(
              height: 100,
              width: 100,
              child: FlutterLogo()),
        ),
      ),
    );
  }
}