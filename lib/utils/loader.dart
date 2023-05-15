// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../res/colors.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // color: primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColor.light_blue,
                  size: 50,
                )
                // CircularProgressIndicator(backgroundColor: Colors.white,),
                ),
          ],
        ),
      ),
    );
  }
}
