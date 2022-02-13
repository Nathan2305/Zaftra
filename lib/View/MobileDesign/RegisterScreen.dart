// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:test_login/Presenter/PresenterRegisterMVP.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/Utils/WidgetsX.dart';
import 'package:test_login/View/Interfaces/interfaceRegisterMVP.dart';

TextEditingController emailController;
TextEditingController nameRestaurantController;
TextEditingController passController;
TextEditingController nameAdminController;
PresenterRegisterMVP presenterRegisterMVP;

ProgressDialog progressLoading;
BuildContext fullContext;
bool emptyFields;
//ShakeController shakeController;
AlertDialog alertDialog;
bool isVerySmall = false;
Size size;
TextStyle textStyle;
OutlineInputBorder outlineInputBorder;

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
    textStyle = TextStyle(
        color: Colors.white, fontSize: 17, decorationColor: Colors.white);
    outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(15));
    fullContext = context;
    presenterRegisterMVP = PresenterRegisterMVP(this);
    return MaterialApp(
      useInheritedMediaQuery: true,
      home: Scaffold(
          //extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: Text('Registro de administrador'),
            backgroundColor: DataSource.secondaryColor,
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
    nameAdminController = TextEditingController();
    nameRestaurantController = TextEditingController();
    passController = TextEditingController();
    //shakeController = ShakeController(vsync: this);
    super.initState();
  }

  @override
  void notifyViewEmptyField() {
    // TODO: implement notifyViewEmptyField
    setState(() {
      emptyFields = true;
    });
    //shakeController.shake();
  }

  @override
  void notifyViewShowPDialogLoading() {
    // TODO: implement notifyViewShowPDialogLoading
    if (emptyFields) {
      setState(() {
        emptyFields = false;
      });
    }
    progressLoading =
        WidgetsX.showProgressDialog(fullContext, "Registrando...",5.sp);
    progressLoading.show();
  }

  @override
  void notifyViewCloseProgressDialog() {
    // TODO: implement notifyViewClosePdialog
    progressLoading.hide();
  }

  @override
  void notifyViewShowErrorMsg(String msgError) {
    // TODO: implement notifyViewShowErrorMsg
    showDialogMsg(msgError, "error");
  }

  showDialogMsg(String msg, String typeMsg) {
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(msg, typeMsg,5.sp);
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TextFieldsEmpty(),
                    _EditTextEmail(),
                    _EditTextNameAdmin(),
                    //_EditTextLastNameAdmin(),
                    _EditTextNameRest(),
                    _EditTextPassword(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: _FabRegister(),
                    )
                  ],
                ),
                /*child: ShakeView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _TextFieldsEmpty(),
                        _EditTextEmail(),
                        _EditTextNameAdmin(),
                        //_EditTextLastNameAdmin(),
                        _EditTextNameRest(),
                        _EditTextPassword(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: _FabRegister(),
                        )
                      ],
                    ),
                    controller: shakeController),*/
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
      margin: EdgeInsets.only(top: 15, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              'Registrar',
              textScaleFactor: 1.5,
              style: TextStyle(color: Colors.white),
            ),
          ),
          FloatingActionButton(
              backgroundColor: DataSource.primaryColor,
              child: Icon(Icons.arrow_forward, size: 30),
              onPressed: initRegister),
        ],
      ),
    );
  }

  initRegister() {
    String emailTxt = emailController.text;
    String nameAdminTxt = nameAdminController.text;
    String nameResTxt = nameRestaurantController.text;
    String passTxt = passController.text;
    presenterRegisterMVP.requestModelValidateRegister(
        emailTxt, nameAdminTxt, nameResTxt, passTxt);
  }
}

class _EditTextPassword extends StatelessWidget {
  final Color color=emptyFields && passController.text.isEmpty? Colors.red:Colors.white;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: TextField(
            obscureText: true,
            cursorColor: Colors.white,
            controller: passController,
            keyboardType: TextInputType.emailAddress,
            style: textStyle,
            decoration: InputDecoration(
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              labelText: 'Contraseña',
              labelStyle: TextStyle(color: color),
            )));
  }
}

class _EditTextNameAdmin extends StatelessWidget {

  final Color color=emptyFields && nameAdminController.text.isEmpty? Colors.red:Colors.white;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        //padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        // decoration: boxDecorationContainer,
        margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: TextField(
            cursorColor: Colors.white,
            controller: nameAdminController,
            keyboardType: TextInputType.emailAddress,
            style: textStyle,
            decoration: InputDecoration(
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              labelText: 'Nombre',
              labelStyle: TextStyle(color: color),
            )));
  }
}

class _EditTextNameRest extends StatelessWidget {
  final Color color=emptyFields && nameRestaurantController.text.isEmpty? Colors.red:Colors.white;

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
            style: textStyle,
            decoration: InputDecoration(
              focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              labelText: 'Nombre de restaurante',
              labelStyle: TextStyle(color: color),
            )));
  }
}

class _EditTextEmail extends StatelessWidget {
 final Color color=emptyFields && emailController.text.isEmpty? Colors.red:Colors.white;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(25, 0, 25, 10),
      child: TextField(
          cursorColor: Colors.white,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: textStyle,
          decoration: InputDecoration(
            focusedBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            labelText: 'Email',
            labelStyle: TextStyle(color: color),
          )),
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
