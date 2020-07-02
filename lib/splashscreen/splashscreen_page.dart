// Importing the Pakages
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:to_do/loginpage/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: Text("TODO", style: TextStyle(fontSize: 80.0, color: Colors.orange, fontWeight: FontWeight.bold),), 
        nextScreen: LoginPage(),
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
        backgroundColor: Colors.white,
        centered: true,
        splashTransition: SplashTransition.scaleTransition,
      )
    );
  }
}