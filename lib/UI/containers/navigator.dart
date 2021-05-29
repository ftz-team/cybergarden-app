import 'package:cybergarden_app/UI/components/navigation.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/enum/Pages.dart';
import 'package:flutter/material.dart';

import 'Home/HomePage.dart';
import 'Map/MapPage.dart';
import 'Profile/ProfilePage.dart';

class AppNavigator extends StatefulWidget {
  NavigatorState createState() => NavigatorState();
}


class NavigatorState extends State<AppNavigator> with TickerProviderStateMixin {

  int active = 0;

  List<Widget> pages = [
    HomePage(),
    MapPage(),
    ProfilePage(),
    ProfilePage(),
  ];

    PageController navController = PageController(initialPage: 0);

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
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: UIGradients.Main,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.map),
              ),
            ),
            onPressed: (){},
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

        shape: CircularNotchedRectangle(),
        notchMargin: width*0.11,

        color: UIColors.background,
        child: Container(
          decoration: BoxDecoration(
            color: UIColors.background
          ),
          padding: EdgeInsets.symmetric(
            vertical: 15
          ),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 4 ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navController.jumpToPage(0);
                      },
                      child: 0!=active?NavItem("assets/home.svg" ,):NavItem.active("assets/home.svg" , ),
                    ),

                    GestureDetector(
                      onTap: () {
                        navController.jumpToPage(1);
                      },
                      child: 1 != active ? NavItem(
                          "assets/star.svg") : NavItem
                          .active(
                        "assets/star.svg",),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(),
              ),
              Expanded(
                flex: 4 ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        navController.jumpToPage(2);
                      },
                      child: 2!=active?NavItem("assets/profile.svg" , ):NavItem.active("assets/profile.svg" , ),
                    ),
                    GestureDetector(
                      onTap: (){
                        navController.jumpToPage(3);
                      },
                      child: 3 != active
                          ? NavItem("assets/profile.svg",
                      )
                          : NavItem.active(
                        "assets/profile.svg",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}