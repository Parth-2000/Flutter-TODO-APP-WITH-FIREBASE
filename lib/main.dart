// Importing the Libraries
import 'package:flutter/material.dart';
import 'package:to_do/splashscreen/splashscreen_page.dart';

// Main Function
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'TO-DO APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange, 
        brightness: Brightness.light,       
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: SplashScreenPage(),
    );
  }
}