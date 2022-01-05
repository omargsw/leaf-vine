import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final Color color;
  final Color colortext;
  final double leftsize;
  final double rightsize;
  final double fontsize;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    required this.color,
    required this.colortext,
    required this.leftsize,
    required this.rightsize,
    required this.fontsize,
     Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => RaisedButton(
    onPressed: onClicked,
    child: Padding(
      padding: EdgeInsets.only(left:leftsize,right:rightsize),
      child: Text(text,style: TextStyle(color: colortext,fontSize: fontsize,fontFamily: 'Simpletax'),),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    color: color,
  );
}