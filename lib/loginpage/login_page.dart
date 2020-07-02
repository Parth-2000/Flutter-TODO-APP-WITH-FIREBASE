// Importing the Libraries
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:to_do/homepage/home_page.dart';
import 'package:to_do/signuppage/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _snackBar = SnackBar(content: Text('Please Enter correct Email and Password!'));
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  bool _autoValidate = false;
  String _email;
  String _password;
  String uid;

  // Validating the user login
  void validateUserLogin(){
    
    if(_fbKey.currentState.validate()){
      _fbKey.currentState.save();
      print(_email);
      print(_password);
      FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _email, 
      password: _password
    ).then((AuthResult auth){
      uid = auth.user.uid;
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(uid: uid)));
    }).catchError((e){
      print(e);
      Scaffold.of(context).showSnackBar(_snackBar);
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
                        Text('Login', style: TextStyle(color: Colors.orange, fontSize: 50.0, fontWeight: FontWeight.bold, letterSpacing: 1.0),textScaleFactor: 1.5,),
                        SizedBox(height: 10.0),
                        
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

                        SizedBox(height: 10.0),
                        returnLoginButton(),
                        SizedBox(height: 10.0),
                        Text('If Not Registered Goto SignUp ?'),
                        SizedBox(height: 10.0),
                        returnRegisterButton(),                        
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

  // Register Button
  Widget returnRegisterButton(){
    return RaisedButton(
      child: Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2), textScaleFactor: 1.5,),
      onPressed: (){    
        Navigator.pop(context); 
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));                     
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
        validateUserLogin();                       
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

  // Validation for email
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

  // Validation for Password
  String validatePassword(dynamic value){
    if(value.toString().length < 8){
      return 'Please Enter 8 Digit Password';
    }else{
      return null;
    }
  }

}














  
  


  