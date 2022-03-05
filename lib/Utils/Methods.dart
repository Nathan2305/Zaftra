import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Methods {
  static Route createRoute(Widget targetRoute) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, -15.0);
        const end = Offset.zero;
        const curve = Curves.bounceInOut;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static void startNewRoute(BuildContext context, Widget routeDestination) {
    Route route = createRoute(routeDestination);
    Navigator.of(context).push(route);
  }

  static Future<bool> validateUserLoggedIn() async {
    bool userLoggedIn=false;
    Map<dynamic, dynamic> mapUser;
    String? objectId = await Backendless.userService.loggedInUser().catchError((onError) {
      PlatformException exception = onError;
      var msgError = 'Error obteniendo sesión de usuario:" $exception';
      print('Error: '+msgError);
    });
    if (objectId != null && objectId.isNotEmpty) {
      mapUser = (await Backendless.data
          .of("Users")
          .findById(objectId)
          .catchError((onError) {
        PlatformException exception = onError;
        //msgError = 'Error obteniendo sesión de usuario:" $exception';
      }))!;
      if (mapUser != null) {
        userLoggedIn=true;
        //MyAppMain.currentUser = BackendlessUser.fromJson(mapUser);

      }
    }
    return userLoggedIn;
  }


  static bool hasItems(List<Object> list){
    return list!=null && list.isNotEmpty;

  }

  static concatenateAttrs(BackendlessUser user, String column_name, String column_last_name) {
    if(user!=null){
      return user.getProperty(column_name).toString() +" "+user.getProperty(column_last_name).toString();
    }
  }
}


