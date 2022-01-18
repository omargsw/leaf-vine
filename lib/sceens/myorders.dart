import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../colors.dart';
import '../main.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  var typeid = sharedPreferences.getInt('typeId');

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void showFloatingSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        "Order has deleted",
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        leading: Text(''),
        backgroundColor: ColorForDesign().broun,
        title:  const Text("My Orders",
          style: TextStyle(color: ColorForDesign.yellowwhite,),
        ),
        centerTitle: true,

      ),
      body: typeid == 1 ?
      Container(
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
                  where("myemail", isEqualTo: '${_auth.currentUser!.email}').where('status',isEqualTo: 1 ).snapshots(),
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
                        itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage('${_auth.currentUser!.photoURL}'),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: docs[index]['title'],
                                        style: TextStyle(
                                            color: ColorForDesign().broun,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: docs[index]['desc'],
                                        style: TextStyle(
                                            color: ColorForDesign().broun,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(onPressed: (){
                                  CollectionReference userRef = FirebaseFirestore.instance.collection('orders');
                                  userRef.doc(docs[index].id).update({
                                    "status" : 0,
                                  }).then((value) {
                                    showFloatingSnackBar(context);
                                  }).catchError((e){
                                    print("Error is $e");
                                  });
                                }, child: const Text('Delete',style: TextStyle(color: Colors.red),))
                              ],
                            )
                          ),
                        );
                      },);

                        GridView.builder(
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
      ) :
      Container(
        color: ColorForDesign.yellowwhite,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
                color: ColorForDesign.yellowwhite,
                width: double.infinity,
                height: double.infinity,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('ordercompleted').
                  where("myemail", isEqualTo: '${_auth.currentUser!.email}').snapshots(),
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
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: ListTile(
                              trailing: Text('Completed',style: TextStyle(color: ColorForDesign().litegreen),),

                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: docs[index]['title'],
                                      style: TextStyle(
                                          color: ColorForDesign().broun,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: docs[index]['desc'],
                                      style: TextStyle(
                                          color: ColorForDesign().broun,
                                          fontSize: 15.0),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Total Price :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0),
                                        ),
                                      ),RichText(
                                        text: TextSpan(
                                          text: docs[index]['totalcost'].toString(),
                                          style: TextStyle(
                                              color: ColorForDesign().broun,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Delivery Cost :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0),
                                        ),
                                      ),RichText(
                                        text: TextSpan(
                                          text: docs[index]['deliverycost'].toString(),
                                          style: TextStyle(
                                              color: ColorForDesign().broun,
                                              fontSize: 15.0),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },);

                      GridView.builder(
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
      ),
    );
  }
}
