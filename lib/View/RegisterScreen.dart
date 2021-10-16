// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:test_login/Presenter/PresenterRegisterMVP.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ShakeView.dart';
import 'package:test_login/Utils/WidgetsX.dart';
import 'package:test_login/View/interfaceRegisterMVP.dart';

TextEditingController emailController = TextEditingController();
TextEditingController nameRestaurantController = TextEditingController();
TextEditingController passController = TextEditingController();
PresenterRegisterMVP presenterRegisterMVP;
ProgressDialog ploading;
BuildContext fullctx;
bool mailEmpty = false;
ShakeController shakeController;
bool visibleError = false;
AlertDialog alertDialog;

void main() {
  runApp(Register());
}

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register>
    with SingleTickerProviderStateMixin
    implements interfaceRegisterMVP {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    fullctx = context;
    presenterRegisterMVP = PresenterRegisterMVP(this);
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

  void change(bool isVisible) {
    setState(() {
      if (visibleError == false) {
        visibleError = isVisible;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    shakeController = ShakeController(vsync: this);
    super.initState();
  }

  @override
  void notifyViewEmptyField() {
    // TODO: implement notifyViewEmptyField
    shakeController.shake();
    change(true);
  }

  @override
  void notifyViewShowPDialogLoading() {
    // TODO: implement notifyViewShowPDialogLoading
    ploading = WidgetsX.showProgressDialog(fullctx, "Registrando");
    ploading.show();
  }

  @override
  void notifyViewClosePdialog() {
    // TODO: implement notifyViewClosePdialog
    ploading.hide();
  }

  @override
  void notifyViewShowErrorMsg(String msgError) {
    // TODO: implement notifyViewShowErrorMsg
    showDialogMsg(msgError, "error");
  }

  showDialogMsg(String msg, String typeMsg) {
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(msg, typeMsg);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewFinishRoute() {
    // TODO: implement notifyViewFinishRoute
    Navigator.pop(context);
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
    //presenterRegisterMVP = PresenterRegisterMVP(RegisterScreen());
    return Scaffold(
        backgroundColor: DataSource.secondaryColor,
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 25, 10, 0),
            child: SingleChildScrollView(
              child: ShakeView(
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
                                visibleError
                                    ? Container(
                                        padding: EdgeInsets.all(3),
                                        color: Colors.black,
                                        child: Text(
                                            '*Debe llenar todos los campos',
                                            style:
                                                TextStyle(color: Colors.red)),
                                      )
                                    : Text(''),
                              ]),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.fromLTRB(35, 0, 35, 20),
                            child: _ButtonRegister(),
                          ),
                        )
                      ],
                    ),
                  ),
                  // ),
                ),
                controller: shakeController,
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
        initRegister(),
      },
      child: Text(
        'Registrar',
      ),
    );
  }

  initRegister() {
    String emailtxt = emailController.text;
    String nameRestxt = nameRestaurantController.text;
    String passtxt = passController.text;
    presenterRegisterMVP.requestModelValidateRegister(
        emailtxt, nameRestxt, passtxt);
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
        controller: passController,
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
        controller: nameRestaurantController,
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
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none),
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
