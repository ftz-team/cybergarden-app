import 'package:cached_network_image/cached_network_image.dart';
import 'package:cybergarden_app/UI/components/heading.dart';
import 'package:cybergarden_app/UI/configs/UIConfig.dart';
import 'package:cybergarden_app/UI/configs/helpers.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CollectorCard.dart';
import '../buttons.dart';

Widget CollectorBottomSheet(BuildContext context, CollectorModel collector) {
  double height = displayHeight(context);
  return Container(

    child: new Container(
      padding: EdgeInsets.only(top: 23, left: 15, right: 15),
      decoration: BoxDecoration(
          color: UIColors.background,
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0))),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: defaultHeader(collector.name),
          ),
          CollectorImage(
            image_url: collector.photo,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: CollectorAdress(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: CollectorDescription(description: collector.description),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10,right: 250),
            child: SecondaryButton(
                child: Text("Контакты",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                onPressed: () {}),
          ),

          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UnicornOutlineButton(
                  strokeWidth: 2,
                  radius: 15,
                  gradient: UIGradients.Main,
                  child: Container(
                    child: Text(
                      "Отметить посещение",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {}),
              InkWell(
                child: new Icon(
                  Icons.favorite_border,
                  color: UIIconColors.active,
                ),
              )
            ],
          )),
          Container(
            height: 20,
          ),
          DefaultButton(
              child: Text("Маршрут",
                  style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              onPressed: () {}),
          Container(
            height: 20,
          )
        ],
      ),
    ),
  );
}
