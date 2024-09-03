import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventContainer extends StatelessWidget {
  const EventContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      height: 90,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: inpBg,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex:1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage("assets/images/kinglear.jfif"),
                  fit: BoxFit.cover
                ),
              ),
            )
          ),
          Expanded(
            flex: 3,
            child: Container(
              
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    text: "King Lear",
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(text: "Date",size: 10,color: hintColor),
                              CustomText(text: "Sep 11",size: 10 , color: Colors.white,),
                            ],
                          ),
                          SizedBox(width: 8,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(text: "Time", size: 10, color: hintColor,),
                              CustomText(text: "09:00 PM",size: 10, color: Colors.white,),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(),
                      Container(
                        padding: EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width/4,
                        height:31 ,
                        decoration: BoxDecoration(
                          color: btnColor,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/icons/ticket.svg",
                            ),
                            // SizedBox(width: 8,),
                            CustomText(text: "600 EGP", color: Colors.white, size: 12,)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}