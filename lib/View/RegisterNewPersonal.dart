import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_login/Presenter/PresenterRegisterUserMVP.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/View/interfaceRegisterUserMVP.dart';
import 'package:test_login/main.dart';

void main() {
  runApp(RegisterNewPersonalScreen());
}

OutlineInputBorder? outlineInputBorder;
TextEditingController? textEditingControllerEmail;
TextEditingController? textEditingControllerName;
TextEditingController? textEditingControllerLastName;
String emailDomain="";
PresenterRegisterUserMVP? presenterRegisterUserMVP;

class RegisterNewPersonalScreen extends StatelessWidget implements interfaceRegisterUserMVP {
  final nameRest = MyAppMain.currentUser
      .getProperty(DataSource.COLUMN_NAME_RESTAURANT)
      .toString()
      .split(" ");

  RegisterNewPersonalScreen(){
    presenterRegisterUserMVP=PresenterRegisterUserMVP(this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    for (int k = 0; k < nameRest.length; k++) {
      String item = nameRest[k];
      if (k == 0) {
        emailDomain = item;
      } else {
        emailDomain = emailDomain + item;
      }
    }
    emailDomain='@'+emailDomain+'.com';

    return MaterialApp(
      useInheritedMediaQuery: true,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: DataSource.primaryColor,
          title: Text('Nuevo personal'),
        ),
        body: ResponsiveWidget(
          mobile: MobileLayoutRegisterNewPersonal(),
        ),
      ),
    );
  }
}

class MobileLayoutRegisterNewPersonal extends StatelessWidget {


 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: DataSource.primaryColor, width: 1.0),
      borderRadius: BorderRadius.circular(15),
    );
    textEditingControllerEmail = TextEditingController();
    textEditingControllerName = TextEditingController();
    textEditingControllerLastName= TextEditingController();
    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _EditTextEmail(),
              _EditTextNameUser(),
              _EditTextLastNameUser(),
              ButtonRegistrar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditTextLastNameUser extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text('Apellidos',style: TextStyle(color: DataSource.primaryColor,fontSize: 15)),
            ),
            TextField(
                cursorColor: Colors.white,
                controller: textEditingControllerLastName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  // height: aspectRatio,
                    color: Colors.black,
                    fontSize: 17,
                    decorationColor: DataSource.primaryColor),
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  labelStyle: TextStyle(color: DataSource.primaryColor),
                  hintStyle: TextStyle(color: DataSource.primaryColor),
                ))
          ],
        ));
  }
}

class ButtonRegistrar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: DataSource.primaryColor,
          elevation: 10,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: TextStyle(fontSize: 20)),
      onPressed: () => {
       initRegisterUser(),
      },
      child: Text(
        'Registrar usuario',
      ),
    );
  }

  initRegisterUser() {
    String name=textEditingControllerName!.text;
    String email=textEditingControllerEmail!.text+emailDomain;
    String lastName=textEditingControllerLastName!.text;
    presenterRegisterUserMVP!.requestModelRegisterUser(name,lastName,email);
  }
}

class _EditTextEmail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text('Email',style: TextStyle(color: DataSource.primaryColor,fontSize: 15)),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                      cursorColor: Colors.white,
                      controller: textEditingControllerEmail,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        // height: aspectRatio,
                          color: Colors.black,
                          fontSize: 17,
                          decorationColor: DataSource.primaryColor),
                      decoration: InputDecoration(
                        focusedBorder: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        labelStyle: TextStyle(color: DataSource.primaryColor),
                        hintStyle: TextStyle(color: DataSource.primaryColor),
                      )),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey,width: 17),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(emailDomain,maxLines: 1,
                        style: TextStyle(fontSize: 17,backgroundColor: Colors.grey,color: Colors.white)),
                  ),
                  flex: 2,
                ),
              ],
            )
          ],
        ));
  }
}

class _EditTextNameUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text('Nombre',style: TextStyle(color: DataSource.primaryColor,fontSize: 15)),
            ),
            TextField(
                cursorColor: Colors.white,
                controller: textEditingControllerName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                  // height: aspectRatio,
                    color: Colors.black,
                    fontSize: 17,
                    decorationColor: DataSource.primaryColor),
                decoration: InputDecoration(
                  focusedBorder: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  labelStyle: TextStyle(color: DataSource.primaryColor),
                  hintStyle: TextStyle(color: DataSource.primaryColor),
                ))
          ],
        ));
  }
}
