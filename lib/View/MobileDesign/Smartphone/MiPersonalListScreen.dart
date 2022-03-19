//@dart=2.9

import 'package:RestaurantAdmin/Model/ModelMainMenuMVP.dart';
import 'package:RestaurantAdmin/Utils/Methods.dart';
import 'package:animate_do/animate_do.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:RestaurantAdmin/Utils/DataSource.dart';
import 'dart:ui' as ui;
import 'package:sizer/sizer.dart';
import 'MyPersonalDetailScreen.dart';
import 'RegisterNewPersonal.dart';

Future<List<BackendlessUser>> listPersonalFuture;
List<BackendlessUser> listPersonal;
AnimationController _controller;
var listKey = GlobalKey<AnimatedListState>();
var _offsetAnimation;

void main() {
  runApp(PersonalScreenState());
}

class PersonalScreenState extends StatefulWidget {
  _PersonalScreenState createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreenState>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
    var myOwnerId = ModelMainMenuMVP.currentUser.getObjectId();
    DataQueryBuilder dataQueryBuilder = DataQueryBuilder()
      ..whereClause = "ownerId='${myOwnerId}' and profile='worker'"
      ..sortBy = ["created DESC"]
      ..pageSize = 100
      ..offset = 0;
    listPersonalFuture = Backendless.data.withClass<BackendlessUser>().find(dataQueryBuilder);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Sizer(
        builder: (context, Orientation orientation, DeviceType deviceType) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: DataSource.primaryColorPersonal,
            title: Text('Mi personal'),
            actions: [
              IconButton(
                  onPressed: () {
                    PushAndWaitData(context);
                  },
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ))
            ],
          ),
          body: FutureBuilder(
            future: listPersonalFuture,
            builder: (BuildContext context,
                AsyncSnapshot<List<BackendlessUser>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinkitLoading();
              } else {
                if (snapshot.hasData) {
                  listPersonal = snapshot.data;
                  return ListWorkersWidget(listPersonal);
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text('Aún no tienes personal registrado'),
                  );
                } else {
                  return Center(
                      child:
                          Text('Error obteniendo personal ${snapshot.error}'));
                }
              }
            },
          ));
    });
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
  final listPersonal;

  ListWorkersWidget(this.listPersonal);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlipInY(
        duration: Duration(seconds: 2),
        child: AnimatedList(
          key: listKey,
          initialItemCount: listPersonal.length,
          itemBuilder: (context, index, animation) {
            var fullName = Methods.concatenateAttrs(listPersonal[index],
                DataSource.COLUMN_NAME, DataSource.COLUMN_LAST_NAME);
            var email = listPersonal[index].email;
            return SlideTransition(
                position: animation.drive(Tween<Offset>(
                  begin: const Offset(-5.5, 5.5),
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
                ));
          },
        ));
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
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
      elevation: 10,
      child: Container(
        width: 30.h,
        height: 30.h,
        //padding: EdgeInsets.all(10),
        child: CustomPaint(
          painter: CardPainter(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(bottom: 3.h),
                  child: Image(
                    width: 35.w,
                    height: 35.w,
                    image: AssetImage('assets/waitress.png'),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                          width: 3, color: DataSource.secondaryColorPersonal)),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fullName,
                          style:
                              TextStyle(fontSize: 17.sp, color: Colors.white)),
                      Text(email,
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white))
                    ],
                  ),
                  padding: EdgeInsets.only(left: 3.w, bottom: 1.h),
                ),
              )
            ],
          ),
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
      color: DataSource.secondaryColorPersonal,
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
        [DataSource.primaryColorPersonal, DataSource.secondaryColorPersonal],
        [0.00, 1.00]);

    Path path0 = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
