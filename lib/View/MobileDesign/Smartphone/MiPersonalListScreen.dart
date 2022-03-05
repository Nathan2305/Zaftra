//@dart=2.9

import 'package:RestaurantAdmin/Utils/Methods.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:RestaurantAdmin/Presenter/PresenterMiPersonalMVP.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'dart:ui' as ui;
import 'package:RestaurantAdmin/View/Interfaces/interfaceMiPersonalMVP.dart';
import 'package:sizer/sizer.dart';
import 'package:focus_detector/focus_detector.dart';
import 'MyPersonalDetailScreen.dart';
import 'RegisterNewPersonal.dart';

//List<String> items;
List<BackendlessUser> listPersonal = List();
Animation<Offset> _offsetAnimation;
var listKey = GlobalKey<AnimatedListState>();

void main() {
  runApp(PersonalScreenState());
}

class PersonalScreenState extends StatefulWidget {
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreenState>
    with SingleTickerProviderStateMixin
    implements interfaceMiPersonalMVP {
  AnimationController _controller;

  //bool emptyWorkers = true;
  bool loadingFinished = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -5.5),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
    PresenterMiPersonalMVP presenterMiPersonalMVP =
        PresenterMiPersonalMVP(this);
    presenterMiPersonalMVP.requestModelLoadPersonal();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (listPersonal != null && listPersonal.isNotEmpty) {
      listPersonal.clear();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Sizer(
        builder: (context, Orientation orientation, DeviceType deviceType) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: DataSource.primaryColor,
            title: Text('Mi personal'),
          ),
          body: !loadingFinished
              ? SpinkitLoading()
              : Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: ListWorkersWidget()),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: FabButtonAddWorker()),
                  ],
                ));
    });
  }

  @override
  void notifyViewShowListPersonal(List<BackendlessUser> listPersonalFound) {
    // TODO: implement notifyViewShowListPersonal
    setState(() {
      //emptyWorkers = false;
      loadingFinished = true;
      //listPersonal = listPersonalFound;
      listPersonal.addAll(listPersonalFound);
    });
  }

  @override
  void notifyViewShowMsgEmptyPersonal() {
    const snackBar =
        SnackBar(content: Text('Aún no tienes trabajadores agregados'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      /* if (!emptyWorkers) {
        emptyWorkers = true;
      }*/
      loadingFinished = true;
    });
  }

  @override
  void notifyViewShowMsgError(String msgError) {
    // TODO: implement notifyViewShowMsgError
  }

  void PushAndWaitData(BuildContext context) async {
    List<BackendlessUser> listNewWorkers = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterNewPersonalScreen()),
    );
      if (Methods.hasItems(listNewWorkers)) {
        for (int pos = 0; pos < listNewWorkers.length; pos++) {
          listPersonal.insert(pos, listNewWorkers.elementAt(pos));
          listKey.currentState.insertItem(pos, duration: Duration(seconds: 1));
        }
      }

  }
}

class ListWorkersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedList(
      key: listKey,
      initialItemCount: listPersonal.length,
      itemBuilder: (context, index, animation) {
        var fullName = Methods.concatenateAttrs(listPersonal[index],
            DataSource.COLUMN_NAME, DataSource.COLUMN_LAST_NAME);
        var email = listPersonal[index].email;
        return SlideTransition(
          position: animation.drive(Tween<Offset>(
            begin: const Offset(-5.5, 0),
            end: const Offset(0.0, 0.0),
          )),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyPersonalDetailScreen(
                        userSelected: listPersonal[index])),
              );
            },
            child: CardEachWorkerWidget(fullName, email),
          ),
        );
      },
    );
  }
}

class CardEachWorkerWidget extends StatelessWidget {
  final fullName;
  final email;

  CardEachWorkerWidget(this.fullName, this.email);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      elevation: 10,
      child: Container(
        width: 100.w,
        height: 45.h,
        //padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              child:
                  Image(height: 20.h, image: AssetImage('assets/waitress.png')),
              margin: EdgeInsets.only(top: 2.h),
            ),
            Container(
              width: 100.w,
              height: 23.h,
              child: CustomPaint(
                  painter: CardPainter(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0.h),
                        child: Text(fullName,
                            style: TextStyle(
                                fontSize: 20.sp, color: Colors.white)),
                      ),
                      Text(email,
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class FabButtonAddWorker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 15, right: 15),
      child: FloatingActionButton(
        //heroTag: "fab-route",
        onPressed: () {
          _PersonalScreenState().PushAndWaitData(context);
        },
        child: Icon(Icons.add),
        elevation: 10,
        backgroundColor: DataSource.primaryColor,
      ),
    );
  }
}

class SpinkitLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SpinKitChasingDots(
      size: 100,
      duration: Duration(seconds: 2),
      color: DataSource.primaryColor,
    );
  }
}

class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(size.width * -0.00, size.height * 0.51),
        Offset(size.width * 1.00, size.height * 0.51),
        [DataSource.primaryColor, DataSource.secondaryColor],
        [0.00, 1.00]);

    Path path0 = Path();
    //path0.moveTo(0,size.height*0.3300000);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width * 0.9983333, size.height * 0.3425000);
    path0.quadraticBezierTo(size.width * 0.8033333, size.height * 0.0181250,
        size.width * 0.6666667, size.height * 0.0175000);
    path0.cubicTo(
        size.width * 0.5854167,
        size.height * 0.0206250,
        size.width * 0.4037500,
        size.height * 0.2918750,
        size.width * 0.3650000,
        size.height * 0.1700000);
    path0.cubicTo(
        size.width * 0.3279167,
        size.height * 0.0593750,
        size.width * 0.1470833,
        size.height * 0.3200000,
        size.width * 0.0633333,
        size.height * 0.1375000);
    path0.quadraticBezierTo(size.width * 0.0087500, size.height * 0.1125000,
        size.width * -0.0016667, size.height * 0.3300000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
