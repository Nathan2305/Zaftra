import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  get boxDecoration => BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Colors.deepOrangeAccent,
            Colors.orangeAccent,
          ]));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'images/logo.png',
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                            Colors.deepOrangeAccent,
                            Colors.orangeAccent,
                          ])),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CardLogin(boxDecoration),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardLogin extends StatelessWidget {
  BoxDecoration boxDecoration;

  CardLogin(this.boxDecoration);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Colors.yellow,
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 20.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.deepOrangeAccent,
                  Colors.orangeAccent,
                ])),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Iniciar sesión",
                    textScaleFactor: 2.2,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _EditTextEmail(),
                  _EditTextPassword(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      textStyle: TextStyle(fontSize: 20)),
                  onPressed: () {},
                  child: Text(
                    'Ingresar',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EditTextPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.deepOrangeAccent,
                Colors.orangeAccent,
              ])),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
      ),
    );
  }
}

class _EditTextEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.deepOrangeAccent,
                Colors.orangeAccent,
              ])),
      margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
          hintText: 'Email', hintStyle: TextStyle(color: Colors.white),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,

          //border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
