// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_login/Utils/DataSource.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  ResponsiveWidget({Key key, this.mobile, this.tablet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= DataSource.MOBILE_MAX_WIDTH) {
          return mobile;
        } else {
          return tablet;
        }
      },
    );
  }
}
