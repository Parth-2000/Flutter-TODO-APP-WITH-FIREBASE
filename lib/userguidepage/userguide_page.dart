// Importing the Pakages
import 'package:flutter/material.dart';

class UserGuidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("User Guide Page", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Center(
            child: Text("User Guide Page", style: TextStyle(color: Colors.orange, fontSize: 40.0))
          ),
        ),
      
      ),
    );
  }
}