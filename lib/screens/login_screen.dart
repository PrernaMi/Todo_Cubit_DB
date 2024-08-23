import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class LoginPage extends StatelessWidget{
  TextEditingController nameController = TextEditingController();

  TextEditingController passController = TextEditingController();

  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Login")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter Your name",
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: TextField(
              controller: passController,
              decoration: InputDecoration(
                  hintText: "Enter Your name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: ElevatedButton(
                onPressed: ()async{
                  prefs =await SharedPreferences.getInstance();
                  prefs!.setString('name', nameController.text.toString());
                  prefs!.setString('pass', passController.text.toString());
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return HomeScreen();
                  }));
                },
                child: Text("Add")
            ),
          )
        ],
      ),
    );
  }
}