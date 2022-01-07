// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/colors.dart';
import 'package:leaf_vine_app/sceens/welcome_page.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import '../main.dart';
import 'login_screen.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var typeid = sharedPreferences.getInt('typeId');
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();



  bool language = false;
  bool _load = false;
  File ? imageFile;
  // final imagePicker = ImagePicker();
  String status = '';
  String photo = '';
  String imagepath = '';


  // Future Uploadimage() async {
  //   if (imageFile == null ) return ;
  //   photo = base64Encode(imageFile!.readAsBytesSync());
  //   imagepath = imageFile!.path.split("/").last;
  // }
  // Future chooseImage(ImageSource source) async {
  //   final pickedFile = await imagePicker.pickImage(source: source);
  //   setState(() {
  //     imageFile = File(pickedFile!.path);
  //     _load = false;
  //   });
  // }
  // setStatus(String message) {
  //   setState(() {
  //     status = message;
  //   });
  // }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "chooseimage",
            style: TextStyle(
              fontSize: 20.0,
              color: ColorForDesign().broun,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.image,color: ColorForDesign().broun,),
              onPressed: () {
                // chooseImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text("gallery",style: TextStyle(color: ColorForDesign().broun,
              ),),

            ),
            FlatButton.icon(
              icon: Icon(Icons.camera_alt,color: ColorForDesign().broun,),
              onPressed: () {
                // chooseImage(ImageSource.camera);
                Navigator.pop(context);

              },
              label: Text("camera",style: TextStyle(color: ColorForDesign().broun,),),

            ),
          ])
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
                            print(typeid);

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

  void _showErrorDialog() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: ColorForDesign().broun,
            content: Text("You must login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorForDesign.yellowwhite,
                )),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen(typeid: 0,)),);
                  },
                  child: Text('Login',
                      style: TextStyle(
                        color: ColorForDesign.yellowwhite,
                      )),
                ),
              ),
            ],
          );
        });
  }

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
                  _AddProduct(context);
                },
                icon: Icon(
                  Icons.add,
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
                child: GridView.builder(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                'assets/img/logo.jpeg',
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Name of user',
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
                                            text: 'title',
                                            style: TextStyle(
                                                color: ColorForDesign().broun,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'desc',
                                            style: TextStyle(
                                                color: ColorForDesign().broun,
                                                fontSize: 20.0),
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
                  itemCount: 5,
                ),
              ),
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
                        child: ListView.builder(
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
                                                text: 'title',
                                                style: const TextStyle(color: Colors.black,
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Simpletax'),),),),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 40,top: 10),
                                            child: Icon(Icons.announcement, color: Colors.white,
                                            ),),

                                        ],
                                      ),

                                      Padding(padding: const EdgeInsets.only(left: 30,top: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'text',
                                            style: const TextStyle(color: Colors.black54,
                                                fontSize: 18.0,
                                                fontFamily: 'Simpletax'),),),),
                                    ],
                                  ),
                                ),
                              );
                          },
                          itemCount: 3, ),
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
              Expanded(
                child: Container(
                color: ColorForDesign.yellowwhite,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      color: ColorForDesign.yellowwhite,
                      width: double.infinity,
                      height: double.infinity,
                      child: GridView.builder(
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  ClipOval(
                                                    child: Image.asset(
                                                      'assets/img/logo.jpeg',
                                                      width: 40,
                                                      height: 40,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 10),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: 'Name of user',
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
                                                  text: 'title',
                                                  style: TextStyle(
                                                      color: ColorForDesign().broun,
                                                      fontSize: 25.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'desc',
                                                  style: TextStyle(
                                                      color: ColorForDesign().broun,
                                                      fontSize: 20.0),
                                                ),
                                              ),
                                            ),
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
                        itemCount: 5,
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ],
          ),
        ),
      );
    }
  }

}