import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorCard.dart';
import 'package:cybergarden_app/UI/components/cards/CollectorUpdated.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/containers/Home/HomeExtPage.dart';
import 'package:cybergarden_app/data/bloc/CollectorsBloc.dart';
import 'package:cybergarden_app/data/bloc/NavigationBloc.dart';
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
                for (var collectorModel in collectors) GestureDetector(
                  onTap :(){
                    Navigator.pop(context);
                    collectorsBloc.addActive(collectorModel);
                  },
                  child: Container(
                    child: UnicornOutlineButton(
                        strokeWidth: 1,
                        radius: 18,
                        gradient: UIGradients.Main,
                        onPressed: (){
                          Navigator.push(context, new CupertinoPageRoute(builder: (context) => HomeExtPage(collectorModel: collectorModel)));
                        },
                        child: Container(
                          width: 350,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: miniHeader(collectorModel.name),
                                margin: EdgeInsets.only(
                                    bottom: 10
                                ),
                              ),
                              CollectorAdress(adress: collectorModel.adress),
                              Container(
                                child: plainText(collectorModel.description.length<40?collectorModel.description:collectorModel.description.substring(0,39)+"...", align: TextAlign.left),
                                margin: EdgeInsets.only(
                                    top: 10,
                                    bottom: 10
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 85,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: CollectorImage(
                                  image_url: collectorModel.photo,
                                ),
                              ),


                            ],
                          ),
                        )
                    ),
                    margin: EdgeInsets.only(
                        bottom: 20
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      )
    );
  }
}