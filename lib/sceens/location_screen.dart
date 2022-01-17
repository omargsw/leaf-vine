import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/sceens/home_screen.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf_vine_app/widgets/nav_bar.dart';

import '../colors.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  var loginemail=TextEditingController();
  late String userEmail;
  final Stream<QuerySnapshot> _newsStream = FirebaseFirestore.instance.collection('news').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        iconTheme: IconThemeData(color: ColorForDesign().litegreen),
        backgroundColor: ColorForDesign().broun,
        title:  const Text("Waste Sorting ",
          style: TextStyle(color: ColorForDesign.yellowwhite,),
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ColorForDesign.yellowwhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 500,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('news').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        ),
                      );
                    }else{
                      final docs = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: docs.length,
                        itemBuilder: (context, int index) {

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Padding(padding: const EdgeInsets.fromLTRB(40, 20, 5, 20),
                                    child:RichText(
                                      text:  TextSpan(
                                        text: docs[index]['title'],
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black45),),),),
                                  Container(
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        style: TextStyle(
                                            color: ColorForDesign().broun),
                                        cursorColor: ColorForDesign().broun,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: "Enter Kilo of ${docs[index]['title']}",
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
                                              width: 1.0,
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
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                      ;
                    }
                  },
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) => Center(
                      child: ButtonWidget(
                        text: "Cancel",
                        color: ColorForDesign().litegreen,
                        colortext:
                        ColorForDesign.yellowwhite,
                        leftsize: 5,
                        rightsize: 5,
                        fontsize: 15,
                        onClicked: () async {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavBar()),);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Builder(
                    builder: (context) => Center(
                      child: ButtonWidget(
                        text: "Arrived",
                        color: ColorForDesign().litegreen,
                        colortext:
                        ColorForDesign.yellowwhite,
                        leftsize: 5,
                        rightsize: 5,
                        fontsize: 15,
                        onClicked: () async {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationScreen()),);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Expanded(child: Column(
              //   children: [
              //     Spacer(),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Builder(
              //           builder: (context) => Center(
              //             child: ButtonWidget(
              //               text: "Cancel",
              //               color: ColorForDesign().litegreen,
              //               colortext:
              //               ColorForDesign.yellowwhite,
              //               leftsize: 5,
              //               rightsize: 5,
              //               fontsize: 15,
              //               onClicked: () async {
              //                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()),);
              //               },
              //             ),
              //           ),
              //         ),
              //         SizedBox(width: 20,),
              //         Builder(
              //           builder: (context) => Center(
              //             child: ButtonWidget(
              //               text: "Arrived",
              //               color: ColorForDesign().litegreen,
              //               colortext:
              //               ColorForDesign.yellowwhite,
              //               leftsize: 5,
              //               rightsize: 5,
              //               fontsize: 15,
              //               onClicked: () async {
              //                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationScreen()),);
              //               },
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     SizedBox(height: 20,),
              //   ],
              // ))
            ],
          ),
        ),
      )
    );
  }
}
