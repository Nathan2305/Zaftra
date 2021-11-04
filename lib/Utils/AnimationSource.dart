import 'package:flutter/cupertino.dart';

class AnimationSource {
  static Route createRoute(Widget targetRoute) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetRoute,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve=Curves.ease;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        //final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
