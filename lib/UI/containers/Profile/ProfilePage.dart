import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  ProfilePageState createState()=>ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    double height = displayHeight(context);
    double width = displayWidth(context);
    return Scaffold(
      body : Container(
          width: width,
          height: height,
          padding : EdgeInsets.symmetric(
              horizontal : 15
          ),
          child : ListView(
            shrinkWrap: true,
            children: [
              Container(
                height: 50,
                width: width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children : [
                      Expanded(child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: new Icon(
                              Icons.settings,
                            )  ,
                          ),
                          Expanded(
                              flex: 7,
                              child: Text(
                                  "Настройки",
                                  style : TextStyle(
                                      color : Colors.white,
                                      fontSize: 16,
                                      fontWeight : FontWeight.w500
                                  )
                              )
                          )
                        ],
                      ))
                    ]
                ),
              )
            ],
          )
      )
    );
  }
}