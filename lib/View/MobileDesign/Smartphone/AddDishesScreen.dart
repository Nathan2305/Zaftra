// @dart=2.9

import 'package:RestaurantAdmin/DAO/Dishes.dart';
import 'package:RestaurantAdmin/Presenter/PresenterAddDishesMVP.dart';
import 'package:RestaurantAdmin/Utils/WidgetsX.dart';
import 'package:RestaurantAdmin/View/Interfaces/interfaceAddDishesMVP.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../Utils/DataSource.dart';

Color colorFields = Colors.white;
TextEditingController controllerNameDish;
TextEditingController controllerPriceDish;
TextEditingController controllerDescDish;
PresenterAddDishesMVP presenterAddDishesMVP;
var categoryGlobal = "";
bool visibleFutureBuilder = false;

class AddDishesScreen extends StatelessWidget {
  AddDishesScreen({Key key, this.categorySent}) : super(key: key);
  final categorySent;

  @override
  Widget build(BuildContext context) {
    categoryGlobal = categorySent;
    // TODO: implement build
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return Scaffold(
          //extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: DataSource.primaryColor,
            toolbarHeight: 0,
            elevation: 0,
          ),
          body: StatefulAddDishes(),
        );
      },
    );
  }
}

class StatefulAddDishes extends StatefulWidget {
  _StatefulDishes createState() => _StatefulDishes();
}

class _StatefulDishes extends State<StatefulAddDishes>
    implements interfaceAddDishesMVP {
  @override
  void initState() {
    // TODO: implement initState
    controllerNameDish = TextEditingController();
    controllerPriceDish = TextEditingController();
    controllerDescDish = TextEditingController();
    presenterAddDishesMVP = PresenterAddDishesMVP(this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerNameDish?.dispose();
    controllerPriceDish?.dispose();
    controllerDescDish?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                DataSource.secondaryColor,
                DataSource.primaryColor
              ], begin: Alignment.center, end: Alignment.topRight)),
              width: 100.w,
              height: 100.h,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ClipPath(
                        clipper: CustomCardCliPath(),
                        child: Card(
                            elevation: 10,
                            margin: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 5.w),
                            color: DataSource.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin:
                                        EdgeInsets.only(left: 4.w, top: 3.h),
                                    child: Text('Nuevo plato',
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            color: Colors.white)),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _EditTextNameDish(14.sp),
                                      _EditTextPriceDish(14.sp),
                                      _EditTextDescDish(14.sp),
                                    ],
                                  ),
                                  _ButtonLogin()
                                ],
                              ),
                            ))),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Image(
                      image: AssetImage('assets/anticucho.png'),
                      width: 50.w,
                      height: 50.w,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void notifyViewShowMsgInfo(String msgType, String msgError) {
    // TODO: implement notifyViewShowMsgInfo
    AlertDialog alertDialog =
        WidgetsX.buildAlertDialog(msgError, msgType, 14.sp);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewCloseLoadingWidget() {
    // TODO: implement notifyViewCloseLoadingWidget
    Navigator.of(context).pop();
  }

  @override
  void notifyViewDishCreatedSuccessfully(Dishes dishCreated) {
    // TODO: implement notifyViewDishCreatedSuccessfully
    controllerDescDish.clear();
    controllerPriceDish.clear();
    controllerNameDish.clear();
    AlertDialog dialogMsgSuccessful=WidgetsX.alertDialogSuccessfulMessage("Se creó el plato ${dishCreated.name} correctamente en la categoría ${categoryGlobal}", 14.sp);
    showDialog(context: context, builder: (BuildContext context){
      return dialogMsgSuccessful;
    });
  }

  @override
  void notifyViewEmptyFields() {
    // TODO: implement notifyViewEmptyFields
    AlertDialog alertDialog = WidgetsX.buildAlertDialog(
        "Debe ingresar toda la información", "warning", 14.sp);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  void notifyViewStartLoadingWidget() {
    // TODO: implement notifyViewStartLoadingWidget
    AlertDialog loadingDialog = WidgetsX.showAlertDialogStandardLoading();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return loadingDialog;
        });
  }


}


class _EditTextNameDish extends StatelessWidget {
  final textSize;

  _EditTextNameDish(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: TextField(
          cursorColor: colorFields,
          controller: controllerNameDish,
          keyboardType: TextInputType.text,
          style: TextStyle(
              color: colorFields,
              fontSize: textSize,
              decorationColor: colorFields),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorFields, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorFields, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Nombre del plato',
            labelStyle: TextStyle(color: colorFields),
            hintStyle: TextStyle(color: colorFields),
          )),
    );
  }
}

class _EditTextPriceDish extends StatelessWidget {
  final textSize;

  _EditTextPriceDish(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 2.h, bottom: 2.h, right: 50.w, left: 8.w),
      child: TextField(
          cursorColor: colorFields,
          controller: controllerPriceDish,
          keyboardType: TextInputType.number,
          style: TextStyle(
              color: colorFields,
              fontSize: textSize,
              decorationColor: colorFields),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorFields, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorFields, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Precio',
            labelStyle: TextStyle(color: colorFields),
            hintStyle: TextStyle(color: colorFields),
          )),
    );
  }
}

class _EditTextDescDish extends StatelessWidget {
  final textSize;

  _EditTextDescDish(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: TextField(
          cursorColor: colorFields,
          maxLines: 5,
          controller: controllerDescDish,
          keyboardType: TextInputType.text,
          style: TextStyle(
              color: colorFields,
              fontSize: textSize,
              decorationColor: colorFields),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorFields, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorFields, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Descripción',
            labelStyle: TextStyle(color: colorFields),
            hintStyle: TextStyle(color: colorFields),
          )),
    );
  }
}

class _ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: DataSource.primaryColor,
              elevation: 10,
              padding: EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              )),
          onPressed: () {
            registerDish();
          },
          child: Text(
            'Agregar plato',
            style: TextStyle(fontSize: 16.sp),
          )),
    );
  }

void registerDish() {
    var nameDishTxt = controllerNameDish.text;
    var priceDishTxt = controllerPriceDish.text;
    var descDishTxt = controllerDescDish.text;

    presenterAddDishesMVP?.requestModelRegisterDish(
        nameDishTxt, priceDishTxt, descDishTxt, categoryGlobal);
  }
}

class CustomCardCliPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    Path path0 = Path();
    path0.lineTo(size.width * 0.5025000, 0);
    path0.quadraticBezierTo(size.width * 0.5212500, size.height * 0.1605000,
        size.width * 0.6450000, size.height * 0.2100000);
    path0.quadraticBezierTo(size.width * 0.7643750, size.height * 0.2590000,
        size.width * 0.9950000, size.height * 0.2920000);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, 0);

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
