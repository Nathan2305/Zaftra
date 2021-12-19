//@dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_login/DAO/Personal.dart';
import 'package:test_login/Presenter/PresenterMiPersonalMVP.dart';
import 'package:test_login/Utils/AnimationSource.dart';
import 'package:test_login/Utils/DataSource.dart';
import 'package:test_login/Utils/ResponsiveWidget.dart';
import 'package:test_login/View/RegisterNewPersonal.dart';
import 'package:test_login/View/interfaceMiPersonalMVP.dart';

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
    implements interfaceMiPersonalMVP {
  List<Personal> listPersonal;
  bool emptyWorkers = true;

  @override
  void initState() {
    // TODO: implement initState
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
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: emptyWorkers
              ? Center(
                  child: Text('Aún no tienes trabajadores agregados',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                )
              : ListView.builder(
                  itemCount: listPersonal.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(listPersonal[index].getNamePersonal),
                    );
                  },
                ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 15, right: 15),
              child: FloatingActionButton(
                onPressed: () {
                  //Navigator.push(context, AnimationSource.createRoute(RegisterNewPersonalScreen()));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterNewPersonalScreen()),
                  );
                },
                child: Icon(Icons.add),
                elevation: 10,
                backgroundColor: DataSource.primaryColor,
              ),
            ))
      ],
    );
  }

  @override
  void notifyViewShowListPersonal(List<Personal> listPersonalFound) {
    // TODO: implement notifyViewShowListPersonal
    setState(() {
      emptyWorkers = false;
      listPersonal = listPersonalFound;
    });
  }

  @override
  void notifyViewShowMsgEmptyPersonal() {
    setState(() {
      if (!emptyWorkers) {
        emptyWorkers = true;
      }
    });
  }

  @override
  void notifyViewShowMsgError(String msgError) {
    // TODO: implement notifyViewShowMsgError
  }
}
