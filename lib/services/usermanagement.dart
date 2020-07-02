// Importing the Libraries
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


 
class UserManagement {
  final databaseReference = Firestore.instance;

  String _emailID;
  String _userUID;
  String _userName;
  DateTime _userDateOfBirth;

  // Create Record of User
  void createUserRecord(uid, email, name, dob) async{

    await FirebaseAuth.instance.currentUser().then((user) {
        email = user.email;
        uid = user.uid;
    });

    _emailID = email;
    _userUID = uid;
    _userName = name;
    _userDateOfBirth = dob;
    await databaseReference.collection("users").document(uid).setData(
      {
        'name': name,
        'email': email,
        'dateofbirth': dob
      }
    );
  }

  String returnUID(){
    return _userUID;
  }

  // Create New Todo Add data to Firebase
  void createNewTodo(title, description) async{
    String uid;

    await FirebaseAuth.instance.currentUser().then((user) {
        uid = user.uid;
    });
    // print("Hello World");
    // print(uid);
    await databaseReference.collection(uid).document().setData(
      {
        'title': title,
        'description': description
      }
    );
  }

  // Update the todo and change in firebase
  void updateTodoData(uid, id, title, description)async {
    await databaseReference.collection(uid).document(id).updateData(
      {
        'title': title,
        'description': description
      }
    );
  }
}
