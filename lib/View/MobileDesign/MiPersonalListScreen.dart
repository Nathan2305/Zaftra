//@dart=2.9

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_login/Presenter/PresenterMiPersonalMVP.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/View/MobileDesign/MyPersonalDetailScreen.dart';
import 'package:test_login/View/MobileDesign/RegisterNewPersonal.dart';
import 'package:test_login/View/Interfaces/interfaceMiPersonalMVP.dart';

//List<String> items;

void main() {
  runApp(MiPersonalScreen());
}

class MiPersonalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: DataSource.primaryColor,
          title: Text('Mi personal'),
        ),
        body: ResponsiveWidget(
          mobile: MobileLayoutMiPersonal(),
        ),
      ),
    );
  }
}

class MobileLayoutMiPersonal extends StatefulWidget {
  StateMiPersonal createState() => StateMiPersonal();
}

class StateMiPersonal extends State<MobileLayoutMiPersonal>
    with SingleTickerProviderStateMixin
    implements interfaceMiPersonalMVP {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  List<BackendlessUser> listPersonal;
  bool emptyWorkers = true;
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
    Widget body = !loadingFinished
        ? SpinKitChasingDots(
            size: 100,
            duration: Duration(seconds: 2),
            color: DataSource.primaryColor,
          )
        : Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: emptyWorkers
                      ? Center(
                          child: Text('Aún no tienes trabajadores agregados',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        )
                      : ListView.builder(
                          itemCount: listPersonal.length,
                          itemBuilder: (context, index) {
                            return SlideTransition(
                              position: _offsetAnimation,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyPersonalDetailScreen(userSelected: listPersonal[index])),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                  elevation: 10,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image(
                                              height: 80,
                                              image: AssetImage(
                                                  'assets/waitress.png')),
                                          flex: 1,
                                        ),
                                        Expanded(
                                            child: Column(
                                              //mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listPersonal[index].getProperty(
                                                      DataSource
                                                          .COLUMN_NAME) +
                                                      " " +
                                                      listPersonal[index]
                                                          .getProperty(DataSource
                                                          .COLUMN_LAST_NAME),
                                                  style: TextStyle(fontSize: 22),
                                                ),
                                                Text(listPersonal[index].email,
                                                    style:
                                                    TextStyle(fontSize: 18))
                                              ],
                                            ),
                                            flex: 3)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15, right: 15),
                    child: FloatingActionButton(
                      //heroTag: "fab-route",
                      onPressed: () {
                        //Navigator.push(context, AnimationSource.createRoute(RegisterNewPersonalScreen()));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterNewPersonalScreen()),
                        );
                      },
                      child: Icon(Icons.add),
                      elevation: 10,
                      backgroundColor: DataSource.primaryColor,
                    ),
                  )),
            ],
          );
    return body;
  }

  @override
  void notifyViewShowListPersonal(List<BackendlessUser> listPersonalFound) {
    // TODO: implement notifyViewShowListPersonal
    setState(() {
      emptyWorkers = false;
      loadingFinished = true;
      listPersonal = listPersonalFound;
    });
  }

  @override
  void notifyViewShowMsgEmptyPersonal() {
    setState(() {
      if (!emptyWorkers) {
        emptyWorkers = true;
      }
      loadingFinished = true;
    });
  }

  @override
  void notifyViewShowMsgError(String msgError) {
    // TODO: implement notifyViewShowMsgError
  }
}
