
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'package:leaf_vine_app/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../colors.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  int typeid;
  var text;
  SignUpScreen({key,required this.typeid,this.text}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var loginformkey = GlobalKey<FormState>();
  var signUpformkey = GlobalKey<FormState>();
  bool _passwordVisible = true;

  bool _passwordsignupVisible = true;
  bool _passwordsignupconfermVisible = true;

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
                key: signUpformkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style:
                        TextStyle(color: Colors.amber, fontSize: 15),
                        cursorColor: ColorForDesign().broun,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_box,
                            color: ColorForDesign().broun,
                          ),
                          labelText: 'Name',
                          labelStyle:
                          TextStyle(color: ColorForDesign().broun),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        onSaved: (newvalue) {
                          signUPName = newvalue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.amber, fontSize: 15),
                        cursorColor: ColorForDesign().broun,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: ColorForDesign().broun,
                          ),
                          labelText: "Email",
                          labelStyle:
                          TextStyle(color: ColorForDesign().broun),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        onSaved: (newvalue) {
                          signUPUserEmail = newvalue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.amber, fontSize: 15),
                        cursorColor: ColorForDesign().broun,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: ColorForDesign().broun,
                          ),
                          labelText: 'Phone number',
                          labelStyle: TextStyle(color: ColorForDesign().broun),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: num,
                        maxLength: 10,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        onSaved: (newvalue) {
                          signUPphoneNumber = newvalue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: _passwordsignupVisible,
                        style:
                        TextStyle(color: Colors.amber, fontSize: 15),
                        cursorColor: ColorForDesign().broun,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordsignupVisible =
                                !_passwordsignupVisible;
                              });
                            },
                            icon: Icon(
                              _passwordsignupVisible
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
                          labelStyle:
                          TextStyle(color: ColorForDesign().broun),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: pass,
                        validator: (value) {
                          confpass = value;
                          if (value!.isEmpty) {
                            return "required";
                          }
                          return null;
                        },
                        onSaved: (newvalue) {
                          signUPpassword = newvalue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: _passwordsignupconfermVisible,
                        style:
                        TextStyle(color: Colors.amber, fontSize: 15),
                        cursorColor: ColorForDesign().broun,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordsignupconfermVisible =
                                !_passwordsignupconfermVisible;
                              });
                            },
                            icon: Icon(
                              _passwordsignupconfermVisible
                                  ? Icons.visibility_sharp
                                  : Icons.visibility_off,
                              color: ColorForDesign().broun,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_clock_sharp,
                            color: ColorForDesign().broun,
                          ),
                          labelText: 'Confirm Password',
                          labelStyle:
                          TextStyle(color: ColorForDesign().broun),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: ColorForDesign().broun,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: pass2,
                        validator: (value) {
                          if (value != confpass) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        onSaved: (newvalue) {
                          signUPConfirmPassword = newvalue!;
                        },
                      ),
                    )
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
                          text: 'Sign Up',
                          color: ColorForDesign().litegreen,
                          colortext: ColorForDesign.yellowwhite,
                          leftsize: 40,
                          rightsize: 40,
                          fontsize: 25,
                          onClicked: ()async{
                            var nametxt = name.text;
                            var emailtxt = email.text;
                            var phonetxt = num.text;
                            var passtxt = pass.text;
                           if (!signUpformkey.currentState!.validate()) {
                              return null;
                            } else {
                              signUpformkey.currentState!.save();
                              if (signUPpassword == signUPConfirmPassword) {
                                try{
                                  UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
                                    email: emailtxt,
                                    password: passtxt,
                                  );

                                  User? user = FirebaseAuth.instance.currentUser;
                                  if (userCrendetial.user!.emailVerified == false) {
                                    await user!.sendEmailVerification();
                                    print("Account created Succesfull");

                                    userCrendetial.user!.updateDisplayName(nametxt);
                                    userCrendetial.user!.updatePhotoURL('http://alarishealth.com/wp-content/uploads/2014/06/no-user.png');
                                    // userCrendetial.user!.updatePhoneNumber(phone);
                                    //PhoneAuthCredential

                                    await _firestore.collection('users').doc(emailtxt).set({
                                      "name": nametxt,
                                      "image" : 'http://alarishealth.com/wp-content/uploads/2014/06/no-user.png',
                                      "email": emailtxt,
                                      "phone": phonetxt,
                                      "typeid": widget.typeid,
                                      "typename" : widget.text,
                                      "uid": _auth.currentUser!.uid,
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginScreen(typeid: widget.typeid,text: widget.text,)),
                                            (Route<dynamic> route) => false);
                                  }

                                }on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    _showErrorDialog('The password is too weak.\n"You must at least enter 6 character"');
                                  } else if (e.code == 'email-already-in-use') {
                                    _showErrorDialog('The account already exists for that email.');
                                  }
                                } catch (e) {
                                  print(e);
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
                          text: "Do you have account",
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
                              text: 'Login',
                              color: ColorForDesign.yellowwhite,
                              colortext: ColorForDesign().broun,
                              leftsize: 20,
                              rightsize: 20,
                              fontsize: 15,
                              onClicked: ()async{
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(typeid: widget.typeid,text: widget.text)),);
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

