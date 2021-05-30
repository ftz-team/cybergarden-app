import 'package:cybergarden_app/UI/components/cards/CollectorUpdated.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  HomePageState createState()=>HomePageState();
}

class HomePageState extends State<HomePage>{

  List<CollectorModel> collectors = [];

  void init() async{
    var res = await getCollectors("all",offline: "true");
    this.setState(() {
      collectors = res;
    });
  }

  @override
  void initState(){
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.background,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 10
              ),
              child: defaultHeader("Скидки и бонусы"),
            ),
            plainText("Помогай экологии вмемсте с нашими портнерами!", align: TextAlign.left),
            Container(
              height: 30,
            ),
            collectors.length == 0? Container(
              height: 24,
              width: 24,
              margin: EdgeInsets.only(
                right: 163,
                left: 163
              ),
              child: CircularProgressIndicator(
                color: UIIconColors.active,
              ),
            ):ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                for (var i in collectors) CollectorUpdated(collectorModel: i,),

              ],
            )
          ],
        ),
      )
    );
  }
}