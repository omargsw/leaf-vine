import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  GlobalKey<FormState> _form= GlobalKey<FormState>();
  var email=TextEditingController();
  final auth = FirebaseAuth.instance;

  Future updatepass(var email, var pass) async {
    String url = 'http://216.128.151.239/api/authintication/updatePassword.php';
    final response = await http.post(Uri.parse(url),
        body: {"email": email.toString(), "password": pass});

    print('RESPONSE------>' + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).pop();
        },
        backgroundColor: ColorForDesign().broun,
        child: const Icon(Icons.arrow_back,color: Colors.white,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
                color: ColorForDesign().white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 20,
                    offset: Offset(0, 10)
                )]
            ),
            child: Form(
              key: _form,
              child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12))
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none
                    ),
                    validator: (value){
                      if(value!.isEmpty)
                        return "Please Enter Your Email";
                      else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                        return "Please Enter The Correct Email ";
                    },

                    controller: email,
                  ),
                ),

              ],
            ),)
          ),),
          RaisedButton(
            onPressed: () async {
              if (_form.currentState!.validate()){
                auth.sendPasswordResetEmail(email: email.text);
                Navigator.of(context).pop();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left:75,right:75),
              child: Text("Send Request",style: TextStyle(color: ColorForDesign().white,),),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: ColorForDesign().broun,
          ),
        ],
      ),
    );
  }
}

