import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EditTextMail_Util extends StatelessWidget {
  final textSize;

  EditTextMail_Util(this.textSize);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 3.h),
      child: TextField(
          cursorColor: Colors.white,
         // controller: controllerEmail,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            // height: aspectRatio,
              color: Colors.white,
              fontSize: textSize,
              decorationColor: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
          )),
    );
  }
}
