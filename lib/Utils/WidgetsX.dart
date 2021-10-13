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
        size: 40,
      );
    } else {
      icon = Icon(
        Icons.error,
        color: Colors.red,
        size: 40,
      );
    }
    AlertDialog alertDialog = AlertDialog(
      title: Text('Mensaje del servidor'),
      //content:
      content: Row(
        children: [
          icon,
          Expanded(child: Text(msg, style: TextStyle(fontSize: 17)))
        ],
      ),
      elevation: 24.0,
    );
    return alertDialog;
  }

  static ProgressDialog showProgressDialog(BuildContext context) {
    ProgressDialog pb = ProgressDialog(context, isDismissible: false);
    pb.style(
        message: 'Iniciando sesión....',
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
