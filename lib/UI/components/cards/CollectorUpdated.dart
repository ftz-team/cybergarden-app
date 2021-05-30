import 'package:cybergarden_app/UI/components/buttons.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:flutter/cupertino.dart';

import '../heading.dart';
import 'CollectorCard.dart';

class CollectorUpdated extends StatelessWidget{

  CollectorModel collectorModel;

  CollectorUpdated({required this.collectorModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: UnicornOutlineButton(
          strokeWidth: 1,
          radius: 18,
          gradient: UIGradients.Main,
          onPressed: (){},
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
                Container(
                  child: subHeader("30.05.2021  12:28"),
                  margin: EdgeInsets.only(
                      bottom: 10
                  ),
                ),
                Container(
                  child: plainText(collectorModel.description, align: TextAlign.left),
                  margin: EdgeInsets.only(
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
    );
  }
}
