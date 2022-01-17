import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'package:leaf_vine_app/widgets/nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../colors.dart';

class OrderRequest extends StatefulWidget {
  var name, email, phone, cost;
   OrderRequest({Key? key,this.email,this.phone,this.name,this.cost}) : super(key: key);

  @override
  _OrderRequestState createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool iscancel = true;
  bool ispicked = false;
  bool isclick = true;
  var loginemail=TextEditingController();
  GlobalKey<FormState> _form= GlobalKey<FormState>();

  var serverToken = "AAAA_ovwEGg:APA91bHulERonfgoLsxJrdzF6KYdRPWEd19TaJTHio_RaVrOjxJlGbrn"
      "_QA_KuBlkD3DkCzjaPkz5nk4nOouht2p3fIkh79z4DqUYrgVxMCyofL8VA36dGzn5Xqsr0tA0TtzPj-f0OmV";

  sendNotify(int id , String title,String body,String uid) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id,
            'status': 'done'
          },
          //الى من رح توصل الرساله

          'to': '/topics/$uid'
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        iconTheme: IconThemeData(color: ColorForDesign.yellowwhite),
        backgroundColor: ColorForDesign().broun,
        title:  const Text("Order Details",
          style: TextStyle(color: ColorForDesign.yellowwhite,),
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Container(
          color: ColorForDesign.yellowwhite,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Client Information',
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),),),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name : ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),),),
                            RichText(
                              text: TextSpan(
                                text: widget.name,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: ColorForDesign().broun),),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Email : ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),),),
                            RichText(
                              text: TextSpan(
                                text: widget.email,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: ColorForDesign().broun),),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'phone : ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),),),
                            RichText(
                              text: TextSpan(
                                text: widget.phone,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: ColorForDesign().broun),),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Cost of delivery : ',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),),),
                            RichText(
                              text: TextSpan(
                                text: widget.cost,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: ColorForDesign().broun),),),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iscancel?
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
                                    var title = 'Leaf Vine';
                                    var body = "${_auth.currentUser!.displayName} canceled the order";
                                    sendNotify(1, title, body, _auth.currentUser!.uid);
                                    await _firestore.collection('notifications').doc().set({
                                      "title": title,
                                      "body": body,
                                      "myname": _auth.currentUser!.displayName,
                                      "myemail" : _auth.currentUser!.email,
                                      "userid" : _auth.currentUser!.uid,
                                      "myimage" : _auth.currentUser!.photoURL,
                                      "sendtoemail" : widget.email,
                                      "sendtoname" : widget.name,
                                      "time": FieldValue.serverTimestamp(),
                                    });
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NavBar()),);
                                  },
                                ),
                              ),
                            ):Container(),
                            SizedBox(width: 20,),
                            isclick ?
                            Builder(
                              builder: (context) => Center(
                                child: ButtonWidget(
                                  text: iscancel?"Arrived" : "Picked Up ",
                                  color: ColorForDesign().litegreen,
                                  colortext:
                                  ColorForDesign.yellowwhite,
                                  leftsize: 5,
                                  rightsize: 5,
                                  fontsize: 15,
                                  onClicked: () async {
                                   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationScreen()),);
                                    if(iscancel == true){
                                      var title = 'Leaf Vine';
                                      var body = "${_auth.currentUser!.displayName} is arrived";
                                      sendNotify(1, title, body, _auth.currentUser!.uid);
                                      await _firestore.collection('notifications').doc().set({
                                        "title": title,
                                        "body": body,
                                        "myname": _auth.currentUser!.displayName,
                                        "myemail" : _auth.currentUser!.email,
                                        "userid" : _auth.currentUser!.uid,
                                        "myimage" : _auth.currentUser!.photoURL,
                                        "sendtoemail" : widget.email,
                                        "sendtoname" : widget.name,
                                        "time": FieldValue.serverTimestamp(),
                                      });
                                      setState(() {
                                        iscancel = false;
                                      });
                                    }else{
                                      print("mesh hello");
                                      setState(() {
                                        ispicked = true;
                                        isclick = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ) : Divider(),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ispicked ?
              Expanded(child: Container(
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
                        physics: NeverScrollableScrollPhysics(),
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
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(left: 10),
                                        hintText: "Kilo of ${docs[index]['title']}",
                                        hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                                        fillColor: Colors.white,
                                        focusColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      validator: (value){
                                        if (value!.isEmpty) {
                                          return "Please enter the current email";
                                        }
                                      },
                                      controller: loginemail,
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
              )) : Container()
            ],
          ),

        ),
      ),

    );
  }
}
