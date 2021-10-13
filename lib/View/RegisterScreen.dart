import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_login/Utils/DataSource.dart';

void main() {
  runApp(Register());
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: RegisterScreen());
  }
}

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return WideLayout();
        } else {
          return NormalLayout();
        }
      },
    );
  }
}

class NormalLayout extends StatelessWidget {
  get boxDecorationCard => BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            DataSource.primaryColor,
            DataSource.secondaryColor,
          ]));

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: DataSource.secondaryColor,
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            DataSource.primaryColor,
                            DataSource.secondaryColor,
                          ]),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Stack(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 30, 0, 0),
                          child: Text(
                            'Registro',
                            textScaleFactor: 2.2,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _EdittTextEmail(boxDecorationCard),
                            _EditTextNameRest(boxDecorationCard),
                            _EditTextPassword(boxDecorationCard),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(35, 10, 20, 35),
                          child: _ButtonRegister(),
                        ),
                      )
                    ],
                  ),
                ),
                // ),
              ),
            ),
          ),
        ));
  }
}

class _ButtonRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: DataSource.secondaryColor,
          elevation: 10,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: TextStyle(fontSize: 20)),
      onPressed: () => {
        // initLogin(),
      },
      child: Text(
        'Registrar',
      ),
    );
  }
}

class _EditTextPassword extends StatelessWidget {
  BoxDecoration boxDecorationCard;

  _EditTextPassword(this.boxDecorationCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: boxDecorationCard,
      margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Password',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        //controller: controllerPasswd,
      ),
    );
  }
}

class _EditTextNameRest extends StatelessWidget {
  BoxDecoration boxDecorationCard;

  _EditTextNameRest(this.boxDecorationCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: boxDecorationCard,
      margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: TextField(
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            icon: Icon(Icons.restaurant),
            hintText: 'Nombre de restaurante',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        //controller: controllerPasswd,
      ),
    );
  }
}

class _EdittTextEmail extends StatelessWidget {
  BoxDecoration boxDecorationCard;

  _EdittTextEmail(this.boxDecorationCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: boxDecorationCard,
      margin: EdgeInsets.fromLTRB(20, 0, 10, 10),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
        //controller: controllerEmail,
        //border: OutlineInputBorder(),
      ),
    );
  }
}

class WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
