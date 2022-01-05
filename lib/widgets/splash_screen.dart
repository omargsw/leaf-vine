// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:leaf_vine_app/colors.dart';
import 'package:leaf_vine_app/sceens/welcome_page.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 4,
        navigateAfterSeconds: WelcomePage(),
        image: Image.asset('assets/img/logo.jpeg',
            fit:BoxFit.cover,
        ),
        backgroundColor: ColorForDesign().white,
        photoSize: 200.0,
        useLoader: true,
        loaderColor: ColorForDesign().broun,
    );
  }
}
