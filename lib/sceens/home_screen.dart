// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/colors.dart';
import 'package:leaf_vine_app/widgets/actionbattons.dart';
import 'login_screen.dart';


class HomeScreen extends StatefulWidget {
  int typeid;
  HomeScreen({Key? key,required this.typeid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
    print("TypeID : ${widget.typeid}");

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
    if(widget.typeid == 1) {
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
                  // if (id == null){
                  //   _showErrorDialog();
                  // }else {
                  //   Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context)=>AddProduct(),
                  //       )
                  //   );
                  // }
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
                              LoginScreen(typeid: 1,text: 'Client Register',)),
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
                              LoginScreen(typeid: 2,text: 'Driver Register',)),
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
                                              print(widget.typeid);
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
      );
    }
  }

}