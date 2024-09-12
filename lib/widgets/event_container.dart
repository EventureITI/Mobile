import 'package:eventure/models/event.dart';
import 'package:eventure/screens/event_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EventContainer extends StatelessWidget {
  final Event event;

  const EventContainer({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => EventScreen(), arguments: event);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(8),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: inpBg, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                        image: NetworkImage(event.imgUrl), fit: BoxFit.cover),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomText(
                        text: event.title,
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
                                  CustomText(
                                      text: "Date", size: 10, color: hintColor),
                                  CustomText(
                                    text: event.eventDate,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                    text: "Time",
                                    size: 10,
                                    color: hintColor,
                                  ),
                                  CustomText(
                                    text: event.startTime,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(),
                          Container(
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width / 4,
                            // height: 31,
                            decoration: BoxDecoration(
                                color: btnColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SvgPicture.asset(
                                  "assets/icons/ticket_fill.svg",
                                ),
                                // SizedBox(width: 8,),
                                CustomText(
                                  text: "${event.price} EGP",
                                  color: Colors.white,
                                  size: 12,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
