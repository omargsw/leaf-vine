import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';

import '../colors.dart';
import 'login_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: ColorForDesign.yellowwhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: Text(
                    "Welcome",
                    style: TextStyle(fontSize: 25, color: ColorForDesign().broun),
                  ),
                ),
              ),
              SizedBox(height: 200,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) => Center(
                      child: ButtonWidget(
                        text: "Driver",
                        color: ColorForDesign().litegreen,
                        colortext: ColorForDesign().broun,
                        leftsize: 15,
                        rightsize: 15,
                        fontsize: 20,
                        onClicked: ()async{
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginScreen(typeid: 2,text: "Driver Register",)),);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Builder(
                    builder: (context) => Center(
                      child: ButtonWidget(
                        text: "Client",
                        color: ColorForDesign().litegreen,
                        colortext: ColorForDesign().broun,
                        leftsize: 15,
                        rightsize: 15,
                        fontsize: 20,
                        onClicked: ()async{
                          // LoginClientScreen
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => LoginScreen(typeid: 1,text: "Client Register",)),);

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}
