
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/sceens/signup_screen.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'package:leaf_vine_app/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../colors.dart';

class LoginScreen extends StatefulWidget {
  int typeid;
  var text;
  LoginScreen({key,required this.typeid,this.text}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var loginformkey = GlobalKey<FormState>();
  var signUpformkey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  var type;

  late String userEmail;
  late String userPassowrd;

  late String signUPUserEmail;
  late String signUPName;
  late String signUPphoneNumber;
  late String signUPpassword;
  late String signUPConfirmPassword;

  bool checkboxvalue = false;
  var email=TextEditingController();
  var pass=TextEditingController();
  var pass2=TextEditingController();
  var name=TextEditingController();
  var num=TextEditingController();
  var loginemail=TextEditingController();
  var loginpass=TextEditingController();
  var confpass;
  Map<String, dynamic>? userMap;



  void _showErrorDialog(String msg) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: ColorForDesign.yellowwhite,
            content: Text(msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorForDesign().broun,
                )),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text('OK',
                      style: TextStyle(
                        color: ColorForDesign().broun,
                      )),
                ),
              ),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorForDesign.yellowwhite,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(505.0),
                  ),
                  elevation: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000.0),
                    child: Image.asset(
                      "assets/img/logo.jpeg",
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 25, color: ColorForDesign().broun),
                ),
              ),
              Form(
                      key: loginformkey,
                      child: Wrap(
                        runSpacing: 10,
                        children: [
                          //-----------Theme for TextFormFields---------------------
                          Theme(
                            data: ThemeData(
                              primaryColor: ColorForDesign().broun,
                              focusColor: ColorForDesign().broun,
                              hintColor: ColorForDesign().broun,
                            ),
                            child: Wrap(
                              runSpacing: 10,
                              children: [
                                //-----------enter your username---------------------
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: ColorForDesign().broun),
                                        cursorColor: ColorForDesign().broun,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: ColorForDesign().broun,
                                          ),
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                              color: ColorForDesign().broun),
                                          fillColor: Colors.amber,
                                          // hoverColor: Colors.amber,
                                          // hintText: "Enter Email",
                                          hintStyle: TextStyle(
                                              color: ColorForDesign().broun),

                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: ColorForDesign().broun,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: ColorForDesign().broun,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: loginemail,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "required";
                                          }
                                          return null;
                                        },
                                        onSaved: (newvalue) {
                                          userEmail = newvalue!;
                                        },
                                      ),
                                    ),

                                    //-----------enter your passowrd---------------------

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        obscureText: _passwordVisible,
                                        style: TextStyle(
                                            color: ColorForDesign().broun),
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility_sharp
                                                  : Icons.visibility_off,
                                              color: ColorForDesign().broun,
                                            ),
                                          ),
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: ColorForDesign().broun,
                                          ),

                                          labelText: "Password",
                                          labelStyle: TextStyle(color: ColorForDesign().broun),
                                          fillColor: Colors.amber,
                                          // hoverColor: Colors.amber,
                                          // hintText: "Enter Email",
                                          // hintStyle: TextStyle(color:  ColorForDesign().green),

                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: ColorForDesign().broun,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: ColorForDesign().broun,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        controller: loginpass,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "required";
                                          }
                                          return null;
                                        },
                                        onSaved: (newvalue) {
                                          userPassowrd = newvalue!;
                                        },
                                      ),
                                    ),

                                  ],
                                )

                                //---------------sign up ---------------------

                                //---------------sign up --------------------------------------------------------------------------------
                              ],
                            ),
                          ),
                          //-----------end Theme for TextFormFields---------------------
                        ],
                      ),
                    ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //-----------RaisedButton login---------------------
                    Builder(
                      builder: (context) => Center(
                        child: ButtonWidget(
                          text: 'Login' ,
                          color: ColorForDesign().litegreen,
                          colortext: ColorForDesign.yellowwhite,
                          leftsize: 40,
                          rightsize: 40,
                          fontsize: 25,
                          onClicked: ()async{
                            var lemail = loginemail.text;
                            var lpass = loginpass.text;
                            if (!loginformkey.currentState!.validate()) {
                              return null;
                            } else {
                              loginformkey.currentState!.save();
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              sharedPreferences.setInt('typeId', widget.typeid);
                              try{
                                UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                                    email: lemail, password: lpass);
                                //ConfirmationResult userCredentialphone = await _auth.signInWithPhoneNumber(phone);
                                _firestore.collection('users').doc(_auth.currentUser!.uid).get().
                                then((value) => userCredential.user!.updateDisplayName(value['name']));
                                User? user = FirebaseAuth.instance.currentUser;
                                if (userCredential.user!.emailVerified == false) {
                                  //await user!.sendEmailVerification();
                                  _showErrorDialog(
                                      'You have to check your email..!');
                                }else{
                                  print("Login Sucessfull");
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  sharedPreferences.setString('email', lemail);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              NavBar()),
                                          (Route<dynamic> route) => false);
                                }

                              }on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  CircularProgressIndicator();
                                  _showErrorDialog('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  _showErrorDialog('The password is incorrect.');
                                }
                              }

                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have account",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18,),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) => Center(
                            child: ButtonWidget(
                              text: 'Sign Up',
                              color: ColorForDesign.yellowwhite,
                              colortext: ColorForDesign().broun,
                              leftsize: 20,
                              rightsize: 20,
                              fontsize: 15,
                              onClicked: ()async{
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(typeid: widget.typeid,text: widget.text,)),);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
