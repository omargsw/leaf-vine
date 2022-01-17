
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../colors.dart';
import '../main.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email2= sharedPreferences.getString('email');
  var typeid = sharedPreferences.getInt('typeId');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userMap;

  GlobalKey<FormState> _form= GlobalKey<FormState>();
  GlobalKey<FormState> _form2= GlobalKey<FormState>();
  GlobalKey<FormState> _form3= GlobalKey<FormState>();
  GlobalKey<FormState> _form4= GlobalKey<FormState>();
  var fname=TextEditingController();
  var phnum=TextEditingController();
  var email=TextEditingController();
  var pass=TextEditingController();
  var pass2=TextEditingController();
  bool ob = true,ob2= true;
  Icon iconpass = Icon(Icons.visibility,color: ColorForDesign().broun);
  Icon iconpass2 = Icon(Icons.visibility,color: ColorForDesign().broun,);
  bool _load = false;
  File ? imageFile;
  final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';
  String ? phone;


  Future getImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    setState(() {
      imageFile = File(pickedFile!.path);
      _load = false;
    });
    uploadImage();

  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    var ref = FirebaseStorage.instance.ref().child('profileimages').child("$fileName");

    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      _auth.currentUser!.updatePhotoURL('$imageUrl');
      await _firestore.collection('users').doc(_auth.currentUser!.email).update({
        "image" : imageUrl,
      }).then((value) {
        showFloatingSnackBar(context);
      }).catchError((e){
        print("Error is $e");
      });

      print("Image Url => "+imageUrl);
    }
  }


  void showFloatingSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        "Updated Successfuly",
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
  void showErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
      backgroundColor: ColorForDesign().broun,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
    );

    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Pic",
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                getImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text("Gallery",style: TextStyle(),),

            ),
          ])
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setdata();
    print(_auth.currentUser!.photoURL);
    print(_auth.currentUser);
  }
  void setdata() async {
    await _firestore.collection('users').where('email',isEqualTo: _auth.currentUser!.email).get().then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print('=========================');
      print(userMap);
      print('=========================');
      print(_auth.currentUser!.uid);

    });
    setState(() {
      fname.text= _auth.currentUser!.displayName!;
      email.text = _auth.currentUser!.email!;
      phnum.text = userMap!['phone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        leading: Text(''),
        backgroundColor: ColorForDesign().broun,
        title:  Text("Edit Profile",
          style: TextStyle(color: ColorForDesign.yellowwhite,),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            child: Column(
              children: [
                Text("Reset",style: TextStyle(color: ColorForDesign().darkyellow),),
                Text("Password",style: TextStyle(color: ColorForDesign().darkyellow),),
              ],
            ),
            onPressed: (){
              _auth.sendPasswordResetEmail(email: email.text);
            },
          ),
        ],
      ),
      body: Container(
        color: ColorForDesign.yellowwhite,
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          child: ListView(
            children: [
              Center(
                child: Center(
                  child: Stack(children: <Widget>[
                    imageFile == null ?
                    CircleAvatar(
                      radius: 80.0,
                      backgroundImage: NetworkImage('${_auth.currentUser!.photoURL}'),

                    ) : CircleAvatar(
                      radius: 80.0,
                      backgroundImage: FileImage(File(imageFile!.path)),

                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      child: Row(
                        children: [
                          imageFile == null ?
                          InkWell(
                            onTap: () async {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );

                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 30.0,
                            ),
                          )
                              :
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => bottomSheet()),

                                  );

                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                              Padding(padding: const EdgeInsets.only(left: 10),
                                child: InkWell(
                                  onTap: () async {

                                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                    int? id= sharedPreferences.getInt('userID');
                                    if (imageFile == null ) return ;
                                    //photo = base64Encode(imageFile!.readAsBytesSync());
                                    //imagepath = imageFile!.path.split("/").last;
                                    //updateImage(id!, imagepath, photo);
                                    imageCache!.clear();
                                    //sharedPreferences.setString('profile_photo_path', imagepath);

                                  },
                                  child: const Icon(
                                    Icons.done,
                                    color: Color.fromARGB(250, 9, 85, 245),
                                    size: 30.0,
                                  ),
                                ),),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ]),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
                 Column(
                  children: <Widget>[
                    Form(
                      key: _form,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          hintText: "${_auth.currentUser!.displayName}",
                          hintStyle: TextStyle(fontSize: 10,fontFamily: 'Simpletax',fontWeight: FontWeight.bold),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.person_outline,color: ColorForDesign().broun,),
                        ),
                        validator: (value){
                          if(value!.length <= 3) {
                            return "Please enter your name";
                          }
                        },
                        controller: fname,
                      ),
                    ),),
                    Form(
                      key: _form2,
                      child:Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          hintText: userMap == null ?"Phone Number.." : "${userMap!['phone']}",
                          hintStyle: TextStyle(fontSize: 10,fontFamily: 'Simpletax',fontWeight: FontWeight.bold),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.local_phone_outlined,color: ColorForDesign().broun,),
                        ),
                        validator: (value){
                          if(value!.length <= 10) {
                            return "Please enter your name";
                          }
                        },

                        controller: phnum,
                      ),

                    ),
                    ),
                    Form(
                      key: _form3,
                      child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          hintText: "${_auth.currentUser!.email!}",
                          hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.email_outlined,color: ColorForDesign().broun,),
                        ),
                        validator: (value){
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value!)) {
                            return "Please enter the current email";
                          }
                        },
                        controller: email,
                      ),
                    ),),
                  ],
                ),
              SizedBox(height: 10,),
              Center(
                child: Builder(
                  builder: (context) => Center(
                    child: ButtonWidget(
                      text: "SAVE",
                      color: ColorForDesign().litegreen,
                      colortext: ColorForDesign.yellowwhite,
                      leftsize: 30,
                      rightsize: 30,
                      fontsize: 15,
                      onClicked: ()async{
                        CollectionReference userRef = FirebaseFirestore.instance.collection('users');
                        final user = FirebaseAuth.instance.currentUser;
                        var name4=fname.text;
                        var phone4=phnum.text;
                        var email4=email.text;
                        if (_form.currentState!.validate()) {
                          if (_form3.currentState!.validate()) {
                            userRef.doc(user!.email).update({
                              "name" : name4,
                              "phone" : phone4,
                              "email" : email4,
                            }).then((value) {
                              showFloatingSnackBar(context);
                            }).catchError((e){
                              print("Error is $e");
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
