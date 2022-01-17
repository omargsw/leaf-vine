import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaf_vine_app/sceens/home_screen.dart';
import 'package:leaf_vine_app/sceens/login_screen.dart';
import 'package:leaf_vine_app/sceens/myorders.dart';
import 'package:leaf_vine_app/sceens/notifications_screen.dart';
import 'package:leaf_vine_app/sceens/profile_screen.dart';

import '../colors.dart';


class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {



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

  int currentTsb =0;
  final List<Widget> screens =[
    HomeScreen(),
    ProfileScreen(),
    MyOrders(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorForDesign().broun,
        child: Icon(Icons.home,color: ColorForDesign().white,),
        onPressed: (){
          setState(() {
            currentScreen = HomeScreen();
            currentTsb=0;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 150,
                    onPressed: (){
                      setState(() {
                        currentScreen = MyOrders();
                        currentTsb=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment,color: ColorForDesign().broun,),
                        Text("My Orders",style: TextStyle(fontSize: 10,color: ColorForDesign().broun),),
                      ],
                    ),

                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 150,
                    onPressed: (){
                      setState(() {
                        currentScreen = ProfileScreen();
                        currentTsb=2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person,color: ColorForDesign().broun,),
                        Text("Account",style: TextStyle(fontSize: 10,color: ColorForDesign().broun),),
                      ],
                    ),

                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
