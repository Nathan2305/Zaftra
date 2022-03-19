import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'DataSource.dart';

class WidgetsX {
  static AlertDialog buildAlertDialog(
      String msg, String typeMsg, double sizeText) {
    Icon icon;
    if ("warning" == typeMsg) {
      icon = Icon(
        Icons.warning,
        color: Colors.orangeAccent,
        size: sizeText * 2,
      );
    } else {
      icon = Icon(
        Icons.error,
        color: Colors.red,
        size: sizeText * 2,
      );
    }
    AlertDialog alertDialog = AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          Text('Mensaje del servidor', style: TextStyle(fontSize: sizeText)),
        ],
      ),
      content: Text(
        msg,
        style: TextStyle(fontSize: sizeText * 0.9),
        textAlign: TextAlign.center,
      ),
      elevation: 24.0,
    );
    return alertDialog;
  }

  static AlertDialog alertDialogSuccessfulMessage(String msg, double textSize) {
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),

      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: textSize*3,
            ),
          ],
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Text(
            msg,
            style: TextStyle(fontSize: textSize),
            textAlign: TextAlign.center,
          ),flex: 1)
        ],
      ),
      elevation: 10,
    );
    return alertDialog;
  }

  static ProgressDialog showProgressDialog(
      BuildContext context, String msg, double textSize) {
    ProgressDialog pb = ProgressDialog(context, isDismissible: false);
    pb.style(
        message: msg,
        messageTextStyle: TextStyle(fontSize: textSize),
        borderRadius: 10.0,
        elevation: 10.0,
        textAlign: TextAlign.center,
        progressWidget: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            child: SpinKitCircle(color: Colors.orangeAccent)));
    return pb;
  }

  static AlertDialog showAlertDialogStandardLoading() {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 120),
      content: FractionallySizedBox(
        heightFactor: 0.1,
        child: SpinKitChasingDots(
          duration: Duration(seconds: 2),
          color: DataSource.primaryColor,
        ),
      ),
      elevation: 24.0,
    );
  }
}
