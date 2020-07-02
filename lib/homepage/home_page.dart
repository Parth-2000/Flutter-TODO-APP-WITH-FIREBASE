// Importing the Pakages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/descriptionpage/description_page.dart';
import 'package:to_do/helppage/help_page.dart';
import 'package:to_do/loginpage/login_page.dart';
import 'package:to_do/services/usermanagement.dart';
import 'package:to_do/userguidepage/userguide_page.dart';
import 'package:to_do/userprofilepage/userprofile_page.dart';

@immutable
class HomePage extends StatefulWidget {
  final String uid;
  HomePage({this.uid});
  @override
  _HomePageState createState() => _HomePageState(uid);
}

class _HomePageState extends State<HomePage> {

  UserManagement _userManagement = UserManagement();
  String uid;
  _HomePageState(this.uid){
    uid = this.uid;
  }

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO APP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: StreamBuilder(
        stream: Firestore.instance.collection('users').document(uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if ((snapshot.connectionState == ConnectionState.waiting) && snapshot.hasError) return new Center(child: new CircularProgressIndicator());
          if (snapshot.hasData && (snapshot.data.documentID.isNotEmpty)) {
            // print(snapshot.data.documentID);
            return Drawer(               
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader( 
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    accountName: Text(snapshot.data['name'], style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 22.0)),
                    accountEmail: Text(snapshot.data['email'], style: TextStyle(color: Colors.black45, fontSize: 18.0, fontWeight: FontWeight.bold)),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("X", style:  TextStyle(color: Colors.orange, fontSize: 22.0, fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                  
                  ListTile(            
                    title: new Text("User Profile"),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage(uid)));
                    }
                  ),
                  ListTile(
                    title: new Text("User Guide"),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserGuidePage()));
                    }
                  ),
                  ListTile(
                    title: new Text("Help"),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                    }
                  ),
                  ListTile(
                    title: new Text("Logout"),
                    trailing: new Icon(Icons.arrow_right),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  ),
                ],
              ),
            );
          }else{
            return new Center(
             child: new Text('You havent set profile'),
           );
          }

        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: (){
          dialogCreateNewTodo(context);
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream:Firestore.instance.collection(uid).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, index){
                DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  title: Text(documentSnapshot['title']),
                  subtitle: Container(
                    margin: EdgeInsets.only(left: 150.0),
                    height: 30.0,
                    width: 20.0,
                    child: FlatButton(                   
                      onPressed: (){
                        dialogUpdateTodo(context, uid, documentSnapshot.documentID);
                      },
                      color: Colors.orange,
                      child: Text("EDIT", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.filter_frames,
                      color: Colors.white,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.orange,
                    ), 
                    color: Colors.orange, 
                    onPressed:(){
                      Firestore.instance.collection(uid).document(documentSnapshot.documentID).delete();
                    }
                  ),
                  onTap: (){
                    String id = documentSnapshot.documentID;
                    String title = documentSnapshot['title'];
                    String description = documentSnapshot['description'];
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage(uid ,id, title, description)));
                  },
                );
              }
            );}else{
              return CircularProgressIndicator(backgroundColor: Colors.orange,);
            }
          }
        ),
      )
    );
  }

  // Alert Dialog for updating the data 
  void dialogUpdateTodo(BuildContext context,String uid, String id) async{
    String _title;
    String _description;
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 120.0),
              child: AlertDialog(
                title: Text('Edit Todo', style: TextStyle(fontSize: 28.0, color: Colors.teal[900])),
                content: Container(
                  height:300.0,
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onChanged: (value) {
                          _title = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold)
                          ),
                        onChanged: (value) {
                          _description = value;
                        },
                      ), 
                      SizedBox(height: 30.0),
                      FlatButton(
                        color: Colors.orange,
                        child: Text('ADD'),
                        textColor: Colors.white,
                        onPressed: () {    
                          _userManagement.updateTodoData(uid, id, _title, _description);
                          Navigator.of(context).pop();               
                        },
                      ),                 
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Alert Dialog for creating the new Todo 
  void dialogCreateNewTodo(BuildContext context) async {
    String _title;
    String _description;

    return showDialog(
      context: context,
        // barrierDismissible: false,
      builder: (BuildContext context) {
        return ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 120.0),
              child: AlertDialog(
                title: Text('Create Todo', style: TextStyle(fontSize: 28.0, color: Colors.teal[900])),
                content: Container(
                  height:300.0,
                  width: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onChanged: (value) {
                          _title = value;
                        },
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold)
                          ),
                        onChanged: (value) {
                          _description = value;
                        },
                      ), 
                      SizedBox(height: 30.0),
                      FlatButton(
                        color: Colors.orange,
                        child: Text('ADD'),
                        textColor: Colors.white,
                        onPressed: () {    
                          _userManagement.createNewTodo(_title, _description);
                          Navigator.of(context).pop();               
                        },
                      ),                 
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}