
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../colors.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
  String ? name2;
  String ? phone2;
  String ? image2;
  String ? email2;
  String photo = '';
  String imagepath = '';


  void setdataimage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? image= sharedPreferences.getString('profile_photo_path');
    setState(() {
      image2 = image;
    });

  }



  Future chooseImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);
    setState(() {
      imageFile = File(pickedFile!.path);
      _load = false;
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  // Future updateName(int id, var name) async {
  //   String url = 'https://www.tabadul.co/tabadulApi/tabadulApi/updatename.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "name": name});
  //
  //   print('UPDATE-NAME------>' + response.body);
  // }
  //
  // Future updatePhone(int id, var phone) async {
  //   String url = 'https://www.tabadul.co/tabadulApi/tabadulApi/updatephone.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "phone": phone});
  //
  //   print('UPDATE-PHONE------>' + response.body);
  // }
  //
  // Future updateImage(int id, var image,var profileDecoded) async {
  //   String url = 'https://www.tabadul.co/tabadulApi/tabadulApi/updateimage.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "profile_photo_path": image,"profileDecoded": profileDecoded});
  //
  //   print('UPDATE-IMAGE------>' + response.body);
  // }
  // Future updateEmail(int id, var email) async {
  //   String url = 'https://www.tabadul.co/tabadulApi/tabadulApi/updateemail.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "email": email});
  //
  //   print('UPDATE-EMAIL------>' + response.body);
  // }
  // Future updatePassword(int id, var password) async {
  //   String url = 'https://www.tabadul.co/tabadulApi/tabadulApi/updatepassword.php';
  //   final response = await http.post(Uri.parse(url),
  //       body: {"id": id.toString(), "password": password});
  //
  //   print('UPDATE-PASSWORD------>' + response.body);
  // }
  //
  // void setdataName() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? name= sharedPreferences.getString('name');
  //   setState(() {
  //     name2 = name;
  //     fname.text= name2!;
  //   });
  // }
  //
  // void setdataphone() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? phone= sharedPreferences.getString('phone');
  //   setState(() {
  //     phone2 = phone;
  //     phnum.text = phone2!;
  //   });
  // }
  //
  // void setdataemail() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? mail= sharedPreferences.getString('email');
  //   setState(() {
  //     email2 = mail;
  //     email.text = email2!;
  //   });
  // }
  //
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setdataName();
  //   setdataphone();
  //   setdataimage();
  //   setdataemail();
  // }

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
                chooseImage(ImageSource.gallery);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: ColorForDesign().broun,
        title:  Text("Edit Profile",
          style: TextStyle(color: ColorForDesign.yellowwhite,),
        ),
        centerTitle: true,

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
                    ClipOval(
                      child: Image.asset('assets/img/nouserimage.jpg',
                      height: 150,),

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
                          hintText: "Name..",
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
                          hintText: "Phone Number..",
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
                          hintText: "Email..",
                          hintStyle: TextStyle(fontSize: 10,fontFamily: 'Simpletax',fontWeight: FontWeight.bold),
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
                    Form(
                      key: _form4,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                hintText: "Password..",
                                hintStyle: TextStyle(fontSize: 10,fontFamily: 'Simpletax',fontWeight: FontWeight.bold),
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                filled: true,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (ob == true) {
                                        ob = false;
                                        iconpass = Icon(Icons.visibility_off,color: ColorForDesign().broun,);
                                      } else {
                                        ob = true;
                                        iconpass = Icon(Icons.visibility,color: ColorForDesign().broun,);
                                      }
                                    });
                                  },
                                  icon: iconpass,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock_outline,color: ColorForDesign().broun,),
                              ),

                              obscureText: ob,
                              controller: pass,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(0),
                                hintText: "Confirm Password..",
                                hintStyle: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(Icons.lock_outline,color: ColorForDesign().broun,),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (ob2 == true) {
                                        ob2 = false;
                                        iconpass2 = Icon(Icons.visibility_off,color: ColorForDesign().broun,);
                                      } else {
                                        ob2 = true;
                                        iconpass2 = Icon(Icons.visibility,color: ColorForDesign().broun,);
                                      }
                                    });
                                  },
                                  icon: iconpass2,
                                ),
                              ),

                              obscureText: ob2,
                              controller: pass2,
                            ),
                          ),
                        ],
                      ),
                    ),
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
