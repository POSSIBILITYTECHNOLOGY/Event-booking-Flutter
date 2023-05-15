// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class AnimatedNavigation extends PageRouteBuilder {
  Widget? child;
  BuildContext? context;

  AnimatedNavigation({required this.child, required this.context})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => child!,
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.bounceOut);
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(animation),
                child: child,
              );
            }
            // =>
            //         FadeTransition(
            //           opacity: animation,
            //           child: child,
            //         )
            );
}
