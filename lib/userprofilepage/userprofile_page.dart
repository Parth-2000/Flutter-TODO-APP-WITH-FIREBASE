// Importing the Pakages
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/services/usermanagement.dart';

class UserProfilePage extends StatefulWidget {
  final String uid;
  UserProfilePage(this.uid);
  @override
  _UserProfilePageState createState() => _UserProfilePageState(this.uid);
}

class _UserProfilePageState extends State<UserProfilePage> {


  UserManagement userManagement = new UserManagement();
  String uid;
  _UserProfilePageState(this.uid);
  String email;
  String name;
  Timestamp dateTime;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Profile Page", style: TextStyle(color: Colors.white)),
        elevation: 0.0,
      ),
      body: StreamBuilder<DocumentSnapshot>(
       stream: Firestore.instance.collection('users').document(uid).snapshots(),
       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) return new Center(child: new CircularProgressIndicator());
         if (snapshot.hasData) {
            dateTime = snapshot.data['dateofbirth'];
            name = snapshot.data['name'];
            email = snapshot.data['email'];
            return Center(
              child: Scaffold(
                backgroundColor: Colors.grey[200],
                body: ListView(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          "User Profile",
                                          style: TextStyle(
                                            color: Colors.orange[600], 
                                            fontSize: 45.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text( 
                                        "Name", 
                                        style: TextStyle(
                                          color: Colors.orange[400],
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text( 
                                        ":-", 
                                        style: TextStyle(
                                          color: Colors.orange[400],
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  
                                  Text( 
                                    (snapshot.data['name'] == null) ? "Loading.." : snapshot.data['name'],
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text( 
                                        "Email", 
                                        style: TextStyle(
                                          color: Colors.orange[400],
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text( 
                                        ":-", 
                                        style: TextStyle(
                                          color: Colors.orange[400],
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),                                    
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text( 
                                        email, 
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text( 
                                        "DOB", 
                                        style: TextStyle(
                                          color: Colors.orange[400],
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text( 
                                        ":-", 
                                        style: TextStyle(
                                          color: Colors.orange[400],
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),                                     
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Text( 
                                    (snapshot.data['dateofbirth'] == null) ? "Loading.." : dateTime.toDate().toString().substring(0, 10),
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
       } else {
           return new Center(
             child: new Center(child: new CircularProgressIndicator()),
           );
         }
       },
     ),
    );
  }
}

  