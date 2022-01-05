
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'package:leaf_vine_app/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';

class LoginScreen extends StatefulWidget {
  int typeid;
  var text;
  LoginScreen({key,required this.typeid,this.text}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  bool loginorsignup = true;
  bool checkboxvalue = false;
  var email=TextEditingController();
  var pass=TextEditingController();
  var pass2=TextEditingController();
  var name=TextEditingController();
  var num=TextEditingController();
  var loginemail=TextEditingController();
  var loginpass=TextEditingController();


  void _showErrorDialog(String msg) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: ColorForDesign().liteblue,
            content: Text(msg,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorForDesign.yellowwhite,
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

  CheckifTheTextBoxEmpty() async {
    var nametxt = name.text;
    var emailtxt = email.text;
    var phonetxt = num.text;
    var passtxt = pass.text;
    var lemail = loginemail.text;
    var lpass = loginpass.text;
    if (loginorsignup == true) {
      if (!loginformkey.currentState!.validate()) {
        return null;
      } else {
        loginformkey.currentState!.save();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NavBar(typeid: widget.typeid,)),
                (Route<dynamic> route) => false);
      }
    }
    //-sign Up for Form------------------------
    else if (!signUpformkey.currentState!.validate()) {
      return null;
    } else {
      signUpformkey.currentState!.save();
      if (signUPpassword == signUPConfirmPassword) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NavBar(typeid: widget.typeid,)),
                (Route<dynamic> route) => false);
      } else {
        _showErrorDialog("password dosen't match");
      }
    }
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
              loginorsignup
                  ? Form(
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
                    )
                  : Form(
                      key: signUpformkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 15),
                              cursorColor: ColorForDesign().broun,
                              keyboardType: TextInputType.emailAddress,
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
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 15),
                              cursorColor: ColorForDesign().broun,
                              keyboardType: TextInputType.emailAddress,
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
                              keyboardType: TextInputType.emailAddress,
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
                              keyboardType: TextInputType.emailAddress,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "required";
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
                          text: loginorsignup ? 'Login' : 'Sign Up',
                          color: ColorForDesign().litegreen,
                          colortext: ColorForDesign.yellowwhite,
                          leftsize: 40,
                          rightsize: 40,
                          fontsize: 25,
                          onClicked: ()async{
                            CheckifTheTextBoxEmpty();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: loginorsignup ? "Don't have account" :
                          "Do you have account",
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
                              text: loginorsignup ? 'Sign Up' : 'Login',
                              color: ColorForDesign.yellowwhite,
                              colortext: ColorForDesign().broun,
                              leftsize: 20,
                              rightsize: 20,
                              fontsize: 15,
                              onClicked: ()async{
                                setState(() {
                                  loginorsignup = !loginorsignup;
                                });
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
