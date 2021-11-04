// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:test_login/Presenter/PresenterRegisterMVP.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/Utils/ShakeView.dart';
import 'package:test_login/Utils/WidgetsX.dart';
import 'package:test_login/View/LoginScreen.dart';
import 'package:test_login/View/interfaceRegisterMVP.dart';

TextEditingController emailController;
TextEditingController nameRestaurantController;
TextEditingController passController;
PresenterRegisterMVP presenterRegisterMVP;

ProgressDialog ploading;
BuildContext fullctx;
bool emptyFields;
ShakeController shakeController;
AlertDialog alertDialog;
bool isVerySmall = false;
Size size;

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
    return MaterialApp(
      home: Scaffold(
        //extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text('Registro'),
            backgroundColor:DataSource.secondaryColor,
          ),
          body: ResponsiveWidget(
            mobile: MobileLayout(),
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    nameRestaurantController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    emptyFields = false;
    emailController = TextEditingController();
    nameRestaurantController = TextEditingController();
    passController = TextEditingController();
    shakeController = ShakeController(vsync: this);
    super.initState();
  }

  @override
  void notifyViewEmptyField() {
    // TODO: implement notifyViewEmptyField
    setState(() {
      emptyFields = true;
    });
    shakeController.shake();
  }

  @override
  void notifyViewShowPDialogLoading() {
    // TODO: implement notifyViewShowPDialogLoading
    if (emptyFields) {
      setState(() {
        emptyFields = false;
      });
    }
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
    initState();
    //Navigator.pushReplacementNamed(context, LoginScreen().toString());
  }
}

class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    if (size.height <= DataSource.SIZE_HEIGHT_VERY_SMALL_DEVICE) {
      isVerySmall = true;
    }
    // TODO: implement build
    return Center(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/register_bground.png'),
                fit: BoxFit.fill)),
        child: Stack(
          children: [
            Align(
              child: SingleChildScrollView(
                child: ShakeView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _TextFieldsEmpty(),
                        _EditTextEmail(),
                        _EditTextNameRest(),
                        _EditTextPassword(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: _FabRegister(),
                        )
                      ],
                    ),
                    controller: shakeController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextFieldsEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.black,
      margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
      child: Text(
        emptyFields ? '**Debe llenar todos los campos**' : '',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _FabRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
      child: FloatingActionButton(
          backgroundColor: DataSource.primaryColor,
          child: Icon(Icons.arrow_forward, size: 30),
          onPressed: initRegister),
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: TextField(
            cursorColor: Colors.white,
            controller: passController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                decorationColor: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Contraseña',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            )));
  }
}

class _EditTextOtherPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: TextField(
            cursorColor: Colors.white,
            controller: passController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                decorationColor: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Ingrese de nuevo Contraseña',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            )));
  }
}

class _EditTextNameRest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: TextField(
            cursorColor: Colors.white,
            controller: nameRestaurantController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                decorationColor: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Nombre de restaurante',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            )));
  }
}

class _EditTextEmail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: TextField(
            cursorColor: Colors.white,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                decorationColor: Colors.white),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(15),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white),
            )));
  }
}

class WideLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
