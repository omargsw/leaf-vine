// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/colors.dart';
import 'package:leaf_vine_app/sceens/notifications_screen.dart';
import 'package:leaf_vine_app/sceens/welcome_page.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import '../main.dart';
import 'location_screen.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   FirebaseAuth _auth = FirebaseAuth.instance;
   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var typeid = sharedPreferences.getInt('typeId');
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();



  bool language = false;
  bool isappro = false;
  bool _load = false;
  File ? imageFile;
  // final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';
   Map<String, dynamic>? userMap;

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

  Widget bottomSheet(var name,var email,var phone,var cost) {
    return Container(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              "Client Informations",
              style: TextStyle(
                fontSize: 20.0,
                color: ColorForDesign().broun,
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            child: Wrap(
              children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   RichText(
                     text: TextSpan(
                       text: 'Name : $name',
                       style: TextStyle(
                           fontFamily: 'Simpletax',
                           fontSize: 18.0,
                           color: Colors.black45),),),
                   SizedBox(height: 5,),
                   RichText(
                     text: TextSpan(
                       text: 'Email : $email',
                       style: TextStyle(
                           fontFamily: 'Simpletax',
                           fontSize: 18.0,
                           color: Colors.black45),),),
                   SizedBox(height: 5,),
                   RichText(
                     text: TextSpan(
                       text: 'Phone Number : $phone',
                       style: TextStyle(
                           fontFamily: 'Simpletax',
                           fontSize: 18.0,
                           color: Colors.black45),),),
                   SizedBox(height: 5,),
                   RichText(
                     text: TextSpan(
                       text: 'Cost of delivery : $cost',
                       style: TextStyle(
                           fontFamily: 'Simpletax',
                           fontSize: 18.0,
                           color: Colors.black45),),),
                   SizedBox(height: 10,),
                   Center(
                     child: Builder(
                     builder: (context) => Center(
                       child: ButtonWidget(
                         text: "Approve",
                         color: ColorForDesign().litegreen,
                         colortext:
                         ColorForDesign.yellowwhite,
                         leftsize: 5,
                         rightsize: 5,
                         fontsize: 15,
                         onClicked: () async {
                           var title = _auth.currentUser!.displayName;
                           var body = "Approve for your order";
                           sendNotify(1, title!, body, _auth.currentUser!.uid);
                           await _firestore.collection('notifications').doc().set({
                             "title": title,
                             "body": body,
                             "myname": _auth.currentUser!.displayName,
                             "myemail" : _auth.currentUser!.email,
                             "userid" : _auth.currentUser!.uid,
                             "myimage" : _auth.currentUser!.photoURL,
                             "sendtoemail" : email,
                             "sendtoname" : name,
                             "time": FieldValue.serverTimestamp(),
                           });

                           //Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationScreen()),);
                         },
                       ),
                     ),
                   ),
                   )
                 ],
               )
              ],
            ),
          )
        ],
      ),
    );
  }

  var selecteditem = null;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(typeid);
    _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).get().then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print('=========================');
      print(userMap);
      print('=========================');

    });
    //from firebase**********************************
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: "@mipmap/logo",
              ),
            ));
      }
    });
//when i click notify **************************************************
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });


    FirebaseMessaging.instance.subscribeToTopic("${_auth.currentUser!.uid}");


  }
  void showFloatingSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        "Added Successful",
        style: TextStyle(fontSize: 15),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black45,
      duration: Duration(seconds: 3),
      shape: StadiumBorder(),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future _AddProduct(context) async {
    return await showDialog(
      context: context,
      builder: ((builder) => AlertDialog(
          backgroundColor: ColorForDesign().broun,
          content: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ListTile(
                        title: Text("Add Order",style: TextStyle(color: ColorForDesign.yellowwhite,fontSize: 20,fontWeight: FontWeight.bold),)
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: title,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: ColorForDesign.yellowwhite),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          hintText: "title",
                          hintStyle: TextStyle(
                              color: ColorForDesign.yellowwhite,
                              letterSpacing: 0,
                              fontSize: 10),
                        ),
                        validator: (value){
                          if(value!.isEmpty) {
                            return "Required";
                          }
                        },
                      ),
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: desc,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: ColorForDesign.yellowwhite),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          hintText: "Desc",
                          hintStyle: TextStyle(
                              color: ColorForDesign.yellowwhite,
                              letterSpacing: 0,
                              fontSize: 10),
                        ),
                        validator: (value){
                          if(value!.isEmpty) {
                            return "Required";
                          }
                        },
                      ),
                    ),
                    Builder(
                      builder: (context) => Center(
                        child: ButtonWidget(
                          text: "SAVE",
                          color: ColorForDesign.yellowwhite,
                          colortext: ColorForDesign().broun,
                          leftsize: 5,
                          rightsize: 5,
                          fontsize: 15,
                          onClicked: () async {
                            await _firestore.collection('orders').doc().set({
                              "title": title.text,
                              "desc": desc.text,
                              "myname": _auth.currentUser!.displayName,
                              "myemail" : _auth.currentUser!.email,
                              "myimage" : _auth.currentUser!.photoURL,
                              "myphone" : userMap!['phone'],
                              "time": FieldValue.serverTimestamp(),
                            });
                            var titlen = 'Order added';
                            var body = "${_auth.currentUser!.displayName} added order";
                            sendNotify(1, titlen, body, _auth.currentUser!.uid);
                            await _firestore.collection('notifications').doc().set({
                              "title": titlen,
                              "body": body,
                              "myname": _auth.currentUser!.displayName,
                              "myemail" : _auth.currentUser!.email,
                              "userid" : _auth.currentUser!.uid,
                              "myimage" : _auth.currentUser!.photoURL,
                              "sendtoemail" : 'all users',
                              "sendtoname" : 'all users',
                              "time": FieldValue.serverTimestamp(),
                            });
                            title.clear();
                            desc.clear();
                            Navigator.of(context).pop();


                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))),
    );
  }

  void _showErrorDialog(var name,var email,var phone,var cost) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: ColorForDesign().broun,
            content: Text("Client Info",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorForDesign.yellowwhite,
                )),
            actions: <Widget>[
             Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Client Informations",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: ColorForDesign().broun,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name : $name',
                                style: TextStyle(
                                    fontFamily: 'Simpletax',
                                    fontSize: 18.0,
                                    color: Colors.black45),),),
                            SizedBox(height: 5,),
                            RichText(
                              text: TextSpan(
                                text: 'Email : $email',
                                style: TextStyle(
                                    fontFamily: 'Simpletax',
                                    fontSize: 18.0,
                                    color: Colors.black45),),),
                            SizedBox(height: 5,),
                            RichText(
                              text: TextSpan(
                                text: 'Phone Number : $phone',
                                style: TextStyle(
                                    fontFamily: 'Simpletax',
                                    fontSize: 18.0,
                                    color: Colors.black45),),),
                            SizedBox(height: 5,),
                            RichText(
                              text: TextSpan(
                                text: 'Const of delivery : $cost',
                                style: TextStyle(
                                    fontFamily: 'Simpletax',
                                    fontSize: 18.0,
                                    color: Colors.black45),),),
                            SizedBox(height: 10,),
                            Center(
                              child: Builder(
                                builder: (context) => Center(
                                  child: ButtonWidget(
                                    text: "Approve",
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
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
            ],
          );
        });
  }



  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('orders').snapshots();
  final Stream<QuerySnapshot> _newsStream = FirebaseFirestore.instance.collection('news').snapshots();

  @override
  Widget build(BuildContext context) {
    if(typeid == 1) {
      return Scaffold(
        backgroundColor: ColorForDesign().white,
        appBar: AppBar(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "For",
                style: TextStyle(color: ColorForDesign().litegreen,fontWeight: FontWeight.bold),
              ),
              Text(
                "Client",
                style: TextStyle(color: ColorForDesign().litegreen,fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Notifications()),);
                },
                icon: Icon(
                  Icons.notifications,
                  color: ColorForDesign.yellowwhite,
                )),
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              WelcomePage()),
                          (Route<dynamic> route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  color: ColorForDesign.yellowwhite,
                )),
          ],
          centerTitle: true,
          title: Text(
            "LEAF VINE",
            style: TextStyle(color: ColorForDesign.yellowwhite),
          ),
          backgroundColor: ColorForDesign().broun,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _AddProduct(context);
          },
          backgroundColor: ColorForDesign().broun,
          child: const Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                color: ColorForDesign.yellowwhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: RichText(
                            text: TextSpan(
                                text: 'News',
                                style: TextStyle(
                                  color: ColorForDesign().litegreen,
                                  fontSize: 4.5 *
                                      (MediaQuery.of(context).size.height / 100),
                                )))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 20, 10),
                      child: Container(
                        height: 125,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _newsStream,
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.only(left: 16,right: 6),
                                itemBuilder: (context, index){
                                  return Container(
                                    margin: EdgeInsets.only(right: 5),
                                    height: 200,
                                    width: MediaQuery.of(context).size.width*0.7,
                                    child: Card(
                                      color: ColorForDesign().broun,
                                      shadowColor: ColorForDesign().broun,
                                      elevation: 3.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(padding: const EdgeInsets.only(left: 40,top: 30),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: docs[index]['title'],
                                                    style: const TextStyle(color: ColorForDesign.yellowwhite,
                                                        fontSize: 24.0,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Simpletax'),),),),
                                              const Padding(
                                                padding: EdgeInsets.only(left: 40,top: 10),
                                                child: Icon(Icons.announcement, color: Colors.white,
                                                ),),

                                            ],
                                          ),

                                          Padding(padding: const EdgeInsets.only(left: 50,top: 10),
                                            child: RichText(
                                              text: TextSpan(
                                                text: "Price per kilo : ${docs[index]['k']}",
                                                style: const TextStyle(color: ColorForDesign.yellowwhite,
                                                    fontSize: 18.0,
                                                    fontFamily: 'Simpletax'),),),),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: docs.length, );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: RichText(
                            text: TextSpan(
                                text: 'Orders',
                                style: TextStyle(
                                  color: ColorForDesign().litegreen,
                                  fontSize: 4.5 *
                                      (MediaQuery.of(context).size.height / 100),
                                )))),
                  ],
                ),
              ),
              Expanded(child: Container(
                color: ColorForDesign.yellowwhite,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      color: ColorForDesign.yellowwhite,
                      width: double.infinity,
                      height: double.infinity,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('orders').
                        where("myemail", isNotEqualTo: '${_auth.currentUser!.email}').snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Center(
                                    child: CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            );
                          }else{
                            final docs = snapshot.data!.docs;
                            return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2,
                              ),
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey,
                                          // offset: const Offset(3, 3),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(16.0)),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              color: ColorForDesign.yellowwhite,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Padding(padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                                        child: ClipOval(
                                                          child: Image.network('${docs[index]['myimage']}',height: 40,),
                                                        ),),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              text: docs[index]['myname'],
                                                              style: TextStyle(
                                                                color: Colors.black26,
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Center(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: docs[index]['title'],
                                                        style: TextStyle(
                                                            color: ColorForDesign().broun,
                                                            fontSize: 20.0,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: docs[index]['desc'],
                                                        style: TextStyle(
                                                            color: ColorForDesign().broun,
                                                            fontSize: 15.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: docs.length,
                            );
                          }
                        },
                      )
                    ),
                  ],
                ),
              ),),
            ],
          ),
        ),
      );
    }else{
      return Scaffold(
        backgroundColor: ColorForDesign().white,
        appBar: AppBar(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "For",
                style: TextStyle(color: ColorForDesign().litegreen,fontWeight: FontWeight.bold),
              ),
              Text(
                "Driver",
                style: TextStyle(color: ColorForDesign().litegreen,fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Notifications()),);
                },
                icon: Icon(
                  Icons.notifications,
                  color: ColorForDesign.yellowwhite,
                )),
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              WelcomePage()),
                          (Route<dynamic> route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  color: ColorForDesign.yellowwhite,
                )),

          ],
          centerTitle: true,
          title: Text(
            "LEAF VINE",
            style: TextStyle(color: ColorForDesign.yellowwhite),
          ),
          backgroundColor: ColorForDesign().broun,
        ),
        body: Container(
          color: ColorForDesign.yellowwhite,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                color: ColorForDesign.yellowwhite,
                width: double.infinity,
                height: double.infinity,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('orders').
                  where("myemail", isNotEqualTo: '${_auth.currentUser!.email}').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        ),
                      );
                    }else{
                      final docs = snapshot.data!.docs;
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 2.1,
                        ),
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey,
                                    // offset: const Offset(3, 3),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: ColorForDesign.yellowwhite,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                                    child: ClipOval(
                                                      child: Image.network('${docs[index]['myimage']}',height: 40,),
                                                    ),),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: docs[index]['myname'],
                                                        style: TextStyle(
                                                          color: Colors.black26,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: docs[index]['title'],
                                                  style: TextStyle(
                                                      color: ColorForDesign().broun,
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: docs[index]['desc'],
                                                  style: TextStyle(
                                                      color: ColorForDesign().broun,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Builder(
                                              builder: (context) => Center(
                                                child: ButtonWidget(
                                                  text: "Book it",
                                                  color: ColorForDesign().litegreen,
                                                  colortext:
                                                  ColorForDesign.yellowwhite,
                                                  leftsize: 5,
                                                  rightsize: 5,
                                                  fontsize: 15,
                                                  onClicked: () async {
                                                    print(typeid);
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: ((builder) => bottomSheet(docs[index]['myname'], docs[index]['myemail'],
                                                          docs[index]['myphone'], '2.00 JD')),

                                                    );
                                                    // setState(() {
                                                    //   if (id == null){
                                                    //     _showErrorDialog();
                                                    //   }else {
                                                    //     showModalBottomSheet(
                                                    //       context: context,
                                                    //       builder: ((builder) =>
                                                    //           bottomSheet(eApi.id, eApi.nameEn, eApi.descEn, eApi.image, eApi.name, eApi.email,
                                                    //             eApi.phone, eApi.userId,)),
                                                    //     );
                                                    //   }
                                                    // });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: docs.length,
                      );
                    }
                  },
                )

              ),
            ],
          ),
        ),
      );
    }
  }
   Row buildNotificationOptionRow(String title, bool isActive) {
     return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(
           title,
           style: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.w500,
               color: Colors.grey[600]),
         ),
         Transform.scale(
             scale: 0.7,
             child: CupertinoSwitch(
               value: isActive,
               onChanged: (bool val) {},
             ))
       ],
     );
   }

}