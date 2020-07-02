// Importing the Libraries
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  final String id;
  final String uid;
  final String title;
  final String description;
  DescriptionPage(this.uid, this.id, this.title, this.description);
  @override
  _DescriptionPageState createState() => _DescriptionPageState(this.uid, this.id, this.title, this.description);
}

class _DescriptionPageState extends State<DescriptionPage> {

  String id;
  String uid;
  String title;
  String description;
  _DescriptionPageState(this.uid, this.id, this.title, this.description);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO Detail", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Column(           
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Title:- ",
                  style: TextStyle(color: Colors.orange, fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Text(title),
                SizedBox(height: 20.0),
                Text("Description:- ",
                  style: TextStyle(color: Colors.orange, fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Text(description),
              ],
            ),
          ],
        ), 
      ),
    );
  }
}