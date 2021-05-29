import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultHeader(String text,{FontWeight fontWeight = FontWeight.bold, Color color = Colors.white, TextAlign textAlign = TextAlign.left} ){
  return Text(
    text,
    style: TextStyle(
        color:  color,
        fontSize: 24,
        fontWeight: fontWeight
    ),
      textAlign :textAlign
  );
}