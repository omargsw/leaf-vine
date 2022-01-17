
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../colors.dart';
import '../main.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String? email= sharedPreferences.getString('email');
  var typeid = sharedPreferences.getInt('typeId');




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Container slideContiner(IconData icon, Color color, String txt) {
    return Container(
      height: 75,
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Text(
            txt,
            style: TextStyle(color: Colors.white),
          )
        ],
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
        title:  Text("Notifications",
          style: TextStyle(color: ColorForDesign.yellowwhite,),
        ),
        centerTitle: true,

      ),
      body: typeid == 1 ?
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notifications').where('sendtoemail',isEqualTo: email).snapshots(),
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
              itemCount: docs.length,
              itemBuilder: (context, int index) {

                return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      InkWell(
                        onTap: () {
                          FirebaseFirestore.instance.collection('notifications').doc().delete();
                          Navigator.of(context).pop();
                        },
                        child: slideContiner(
                            Icons.delete, Colors.red, "Delete"),
                      )
                    ],
                    child: Container(
                        margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                        decoration: BoxDecoration(
                            color: ColorForDesign.yellowwhite,
                            borderRadius: BorderRadiusDirectional.circular(8)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            radius: 28,
                            backgroundImage: NetworkImage(docs[index]['myimage']),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                docs[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorForDesign().broun),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                docs[index]['body'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          onTap: () {

                          },
                        )),
                  );
              },
            );
            ;
          }
        },
      ) :
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notifications').where('sendtoemail',isEqualTo: 'all users').snapshots(),
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
              itemCount: docs.length,
              itemBuilder: (context, int index) {

                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: slideContiner(
                          Icons.delete, Colors.red, "Delete"),
                    )
                  ],
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      decoration: BoxDecoration(
                          color: ColorForDesign.yellowwhite,
                          borderRadius: BorderRadiusDirectional.circular(8)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        leading: CircleAvatar(
                          radius: 28,
                          backgroundImage: NetworkImage(docs[index]['myimage']),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              docs[index]['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorForDesign().broun),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              docs[index]['body'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        onTap: () {

                        },
                      )),
                );
              },
            );
            ;
          }
        },
      ),
    );
  }
}
//'https://www.tabadul.co/images/profile/' + notifiApi.profilePhotoPath
