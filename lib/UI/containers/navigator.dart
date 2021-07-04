import 'dart:async';

import 'package:cybergarden_app/UI/components/navigation.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
import 'package:cybergarden_app/data/enum/Pages.dart';
import 'package:flutter/material.dart';

import 'Courses/CoursesPage.dart';
import 'Home/HomePage.dart';
import 'Map/MapPage.dart';
import 'Profile/ProfilePage.dart';

class AppNavigator extends StatefulWidget {
  NavigatorState createState() => NavigatorState();
}


class NavigatorState extends State<AppNavigator> with TickerProviderStateMixin {

  late StreamSubscription _subscription;
  int active = 0;

  List<Widget> pages = [
    HomePage(),
    MapPage(),
    ProfilePage(),
    ProfilePage(),
    CoursesPage(),
  ];

    PageController navController = PageController(initialPage: 1);

    @override
    void initState(){
      _subscription = navigationBloc.tab.listen((data) {
        this.setState(() {
          active = data;
        });
        navController.jumpToPage(data);
      });
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    double width = displayWidth(context);
    return Scaffold(
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: displayWidth(context) * 0.175,
          child: FloatingActionButton(
            child: InkWell(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: UIGradients.Main,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.map),
              ),
            ),
            onPressed: (){
              navController.jumpToPage(1);
            },
          ),
        ),

      body: PageView(

        controller: navController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (int) {
          setState(() {
            active = int;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: BottomAppBar(

        shape: CircularNotchedRectangle(

        ),
        notchMargin: 50,

        color: UIColors.background,
        child: Container(
          decoration: BoxDecoration(
            color: UIColors.background
          ),
          padding: EdgeInsets.only(
            top: 10,
            bottom: 5
          ),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 4 ,
                child:                     GestureDetector(
                  onTap: (){
                    navController.jumpToPage(0);
                  },
                  child: 0!=active?NavItem("assets/home.svg" ,):NavItem.active("assets/home.svg" , ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Expanded(
                flex: 4 ,
                child:                    GestureDetector(
                  onTap: (){
                    navController.jumpToPage(2);
                  },
                  child: 2!=active?NavItem("assets/profile.svg" , ):NavItem.active("assets/profile.svg" , ),
                ),
              )
            ],
          ),
        )
      )
    );
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}