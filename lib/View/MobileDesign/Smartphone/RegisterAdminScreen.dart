// @dart=2.9
import 'package:RestaurantAdmin/Utils/WidgetsX.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceRegisterAdminMVP.dart';
import 'package:RestaurantAdmin/View/MobileDesign/Smartphone/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:RestaurantAdmin/Presenter/PresenterRegisterAdminMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';

import 'dart:ui' as ui;

import '../../../Utils/Methods.dart';

TextEditingController businessController;
TextEditingController ownerController;
TextEditingController emailController;
TextEditingController passController;

PresenterRegisterAdminMVP presenterRegisterAdminMVP;
var colorTexts = Colors.white;
BuildContext globalContext;

void main() {
  runApp(RegisterAdminScreen());
}

class RegisterAdminScreen extends StatefulWidget {
  _RegisterAdminScreen createState() => _RegisterAdminScreen();
}

class _RegisterAdminScreen extends State<RegisterAdminScreen>
    implements interfaceRegisterAdminMVP {
  var opacityValue = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    presenterRegisterAdminMVP = PresenterRegisterAdminMVP(this);

    businessController = TextEditingController();
    ownerController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    businessController.dispose();
    ownerController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //globalContext=context;
    // final keyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Opacity(
            opacity: opacityValue,
            child: AbsorbPointer(
              absorbing: opacityValue == 1 ? false : true,
              child: Container(
                height: 100.h,
                width: 100.w,
                child: CustomPaint(
                  painter: RegisterPainter(),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _RegisterTitle(24.sp),
                          _EditTextNameBusiness(14.sp),
                          _EditTextOwner(14.sp),
                          _EditTextEmail(14.sp),
                          _EditTextPassword(14.sp),
                          Visibility(
                            visible: opacityValue == 1 ? false : true,
                            child: LoadingWidgetProgress(),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FabRegister(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )),
      );
    });
  }

  @override
  void notifyViewCloseProgressDialog() {
    // TODO: implement notifyViewCloseProgressDialog
    setState(() {
      opacityValue = 1;
    });
  }

  @override
  void notifyViewEmptyField() {
    //debe llenar todos los campos
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(
        "Debe llenar todos los campos", "warning", 13.sp);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewFinishRoute() {
    // TODO: implement notifyViewFinishRoute
    bool canPop = Navigator.canPop(context);
    if (canPop) {
      Navigator.pop(context);
    } else {

    }
  }

  @override
  void notifyViewShowErrorMsg(String msgError) {
    AlertDialog alertDialog =
        WidgetsX.buildAlertDialog(msgError, "error", 13.sp);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewShowPDialogLoading() {
    // TODO: implement notifyViewShowPDialogLoading
    setState(() {
      opacityValue = 0.7;
    });
  }

  @override
  void notifyViewSuccessfulAdminsCreated() {
    // TODO: implement notifyViewSuccessfulAdminsCreated
    emailController.clear();
    ownerController.clear();
    businessController.clear();
    passController.clear();
    notifyViewFinishRoute();
  }
}

class _RegisterTitle extends StatelessWidget {
  final titleHeight;

  _RegisterTitle(this.titleHeight);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 3.h),
      child: Text('Registro',
          style: TextStyle(fontSize: titleHeight, color: Colors.white)),
    );
  }
}

class LoadingWidgetProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //color: Colors.transparent,
      alignment: Alignment.center,
      child: SpinKitCircle(
        color: Colors.blueAccent,
        size: 20.w,
      ),
    );
  }
}

class FabRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 2.h, right: 3.w, bottom: 2.h),
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        elevation: 10,
        backgroundColor: DataSource.primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          registerAdmin();
        },
      ),
    );
  }

  void registerAdmin() {
    var businessName = businessController.text;
    var owner = ownerController.text;
    var email = emailController.text;
    var passwd = passController.text;
    presenterRegisterAdminMVP.requestModelValidateRegister(
        businessName, owner, email, passwd);
  }
}

class RegisterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var widthParent = size.width;
    var heightParent = size.height;
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
          Offset(0, size.height * 0.56),
          Offset(size.width * 1.00, size.height * 0.56),
          [DataSource.primaryColor, DataSource.secondaryColor],
          [0.00, 1.00]);
    // ..strokeWidth=5;
    Path path0 = Path();
    path0.moveTo(0, heightParent * 0.228927);
    path0.quadraticBezierTo(widthParent * 0.1173800, heightParent * 0.2062675,
        widthParent * 0.2005000, heightParent * 0.1527994);
    path0.quadraticBezierTo(widthParent * 0.2635000, heightParent * 0.1053655,
        widthParent * 0.3005000, 0);
    path0.lineTo(widthParent, 0);
    path0.lineTo(widthParent, heightParent);
    path0.quadraticBezierTo(widthParent * 0.7448800, heightParent * 0.8942457,
        widthParent * 0.5000000, heightParent * 0.8938569);
    path0.quadraticBezierTo(
        widthParent * 0.2580000, heightParent * 0.8973561, 0, heightParent);
    path0.lineTo(0, heightParent * 0.2328927);
    path0.close();

    canvas.drawPath(path0, paint);

    canvas.drawPath(path0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class _EditTextNameBusiness extends StatelessWidget {
  final textSize;

  _EditTextNameBusiness(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // margin: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 2.h),
      child: TextField(
          cursorColor: colorTexts,
          controller: businessController,
          keyboardType: TextInputType.text,
          style: TextStyle(
              // height: aspectRatio,
              color: colorTexts,
              fontSize: textSize,
              decorationColor: colorTexts),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Nombre del restaurante',
            labelStyle: TextStyle(color: colorTexts),
            hintStyle: TextStyle(color: colorTexts),
          )),
    );
  }
}

class _EditTextOwner extends StatelessWidget {
  final textSize;

  _EditTextOwner(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: TextField(
          cursorColor: colorTexts,
          controller: ownerController,
          keyboardType: TextInputType.text,
          style: TextStyle(
              // height: aspectRatio,
              color: colorTexts,
              fontSize: textSize,
              decorationColor: colorTexts),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Propietario',
            labelStyle: TextStyle(color: colorTexts),
            hintStyle: TextStyle(color: colorTexts),
          )),
    );
  }
}

class _EditTextEmail extends StatelessWidget {
  final textSize;

  _EditTextEmail(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: TextField(
          cursorColor: colorTexts,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              // height: aspectRatio,
              color: colorTexts,
              fontSize: textSize,
              decorationColor: colorTexts),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: colorTexts),
            hintStyle: TextStyle(color: colorTexts),
          )),
    );
  }
}

class _EditTextPassword extends StatelessWidget {
  final textSize;

  _EditTextPassword(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      child: TextField(
          cursorColor: colorTexts,
          controller: passController,
          obscureText: true,
          style: TextStyle(
              // height: heightText,
              color: colorTexts,
              fontSize: textSize,
              decorationColor: colorTexts),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorTexts, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Contraseña',
            labelStyle: TextStyle(color: colorTexts),
            hintStyle: TextStyle(color: colorTexts),
          )),
    );
  }
}
