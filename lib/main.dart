import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:launcher/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'images/logo.png',
          width: 500,
        ),
        nextScreen: HomePage(),
        splashTransition: SplashTransition.rotationTransition,
        backgroundColor: HexColor('#ea80fc'),
      ),
    );
  }
}
