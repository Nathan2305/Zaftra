import 'package:flutter/material.dart';

//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';

class WidgetsX {
  static AlertDialog buildAlertDialog(String msg, String typeMsg) {
    Icon icon;
    if ("warning" == typeMsg) {
      icon = Icon(
        Icons.warning,
        color: Colors.yellowAccent,
        size: 30,
      );
    } else {
      icon = Icon(
        Icons.error,
        color: Colors.red,
        size: 30,
      );
    }
    AlertDialog alertDialog = AlertDialog(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          Text('Mensaje del servidor'),
        ],
      ),
      content: Container(
        child: Text(msg, style: TextStyle(fontSize: 17)),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      ),
      elevation: 24.0,
    );
    return alertDialog;
  }

  static ProgressDialog showProgressDialog(BuildContext context, String msg) {
    ProgressDialog pb = ProgressDialog(context, isDismissible: false);
    pb.style(
        message: msg,
        messageTextStyle: TextStyle(fontSize: 20),
        borderRadius: 10.0,
        elevation: 10.0,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrangeAccent,
                strokeWidth: 5,
                color: Colors.orangeAccent)));
    return pb;
  }
}
