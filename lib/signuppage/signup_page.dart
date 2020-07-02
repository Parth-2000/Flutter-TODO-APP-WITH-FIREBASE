// Importing the Libraries
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:to_do/loginpage/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/services/usermanagement.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  UserManagement userManagement = UserManagement();

  String _email;
  String _password;
  String _name;
  DateTime _dob;
  String uid;

  bool _autoValidate = false;

  // Validate the Form
  void _sendToServer(){
    if(_fbKey.currentState.validate()){
      _fbKey.currentState.save();
      // print(_email);
      // print(_password);
      // print(_name);
      // print(_dob);
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email, 
        password: _password
      ).then((authResult){
        String uid =authResult.user.uid;
        userManagement.createUserRecord(uid, _email, _name, _dob);
      }).then((result){
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        _fbKey.currentState.reset();
      }).catchError((e){
        print(e);
      });
    }else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Center(
              child: FormBuilder(
                key: _fbKey,
                autovalidate: _autoValidate,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(25.0, 80.0, 25.0, 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                        Text('SignUp', style: TextStyle(color: Colors.orange, fontSize: 50.0, fontWeight: FontWeight.bold, letterSpacing: 1.0),textScaleFactor: 1.5,),
                        SizedBox(height: 10.0),
                        
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(labelText: "Name"),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          onSaved: (value){
                            this._name = value;
                          },
                          validators: [
                            validateName,
                            FormBuilderValidators.required(),
                          ],
                        ),

                        FormBuilderTextField(
                          attribute: "emailId",
                          decoration: InputDecoration(labelText: "Email"),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value){
                            this._email = value;
                          },
                          
                          validators: [
                            validateEmail,
                            FormBuilderValidators.email(),
                            FormBuilderValidators.required(),
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "password",
                          decoration: InputDecoration(labelText: "Password"),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          maxLength: 8,
                          maxLines: 1,
                          onSaved: (value){
                            this._password = value;
                          },
                          validators: [
                            validatePassword,
                            // FormBuilderValidators.max(8),
                            FormBuilderValidators.required(),
                          ],
                        ),

                        FormBuilderDateTimePicker(
                          attribute: "date",
                          inputType: InputType.date,
                          format: DateFormat("yyyy-MM-dd"),
                          decoration: InputDecoration(labelText: "DOB"),
                          onSaved: (value){
                            this._dob = value;
                          },
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        returnRegisterButton(),
                        SizedBox(height: 10.0),
                        Text('Already Registered Goto Login ?'),
                        SizedBox(height: 10.0),
                        returnLoginButton(),
                        SizedBox(height: 20.0),
                        returnForgetPasswordButton()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Validating the Name
  String validateName(dynamic value){
    if(value.toString().isEmpty){
      return "Please Enter Name";
    }else{
      return null;
    }
  }

  // Validating the Email
  String validateEmail(dynamic value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.toString())){
      return 'Enter Valid Email';
    }else{
      return null;
    }
  }

  // Validating the Password
  String validatePassword(dynamic value){
    if(value.toString().length < 8){
      return 'Please Enter 8 Digit Password';
    }else{
      return null;
    }
  }

  // Register Button
  Widget returnRegisterButton(){
    return RaisedButton(
      child: Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2), textScaleFactor: 1.5,),
      onPressed: (){    
        _sendToServer();                      
      },
      color: Colors.orange[400],
      elevation: 7.0,
      textColor: Colors.white,
    );
  }

  // Login Button
  Widget returnLoginButton(){
    return RaisedButton(
      child: Text('login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2), textScaleFactor: 1.5,),
      onPressed: (){   
        Navigator.pop(context);  
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));                     
      },
      color: Colors.orange[400],
      elevation: 7.0,
      textColor: Colors.white,
    );
  }

  // Forget Password Button
  Widget returnForgetPasswordButton(){
    return OutlineButton(
      child: Text('Forget Password ?', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, letterSpacing: 2), textScaleFactor: 1.5,),
      onPressed: (){},
      color: Colors.orange[300],
      highlightColor: Colors.orangeAccent,
      borderSide: BorderSide(
        color: Colors.green
      ),
    );
  }
}














  
  


  