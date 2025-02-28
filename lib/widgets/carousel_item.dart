import 'package:eventure/models/event.dart';
import 'package:eventure/screens/event_screen.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CarouselItem extends StatelessWidget {
  final Event event;
  final RxList categories;
  final double? contHeight;
  final double? marginBtm;

  const CarouselItem({
    super.key,
    required this.event,
    required this.categories,
    this.contHeight,
    this.marginBtm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: contHeight,
      margin: EdgeInsets.only(bottom: marginBtm ?? 0.0),
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () {
          Get.to(() => EventScreen(), arguments: event);
        },
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 224,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        image: DecorationImage(
                            image: NetworkImage(event.imgUrl),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 224,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      gradient: LinearGradient(
                        begin: Alignment(-0.02, 2.00),
                        end: Alignment(0.02, -1),
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.800000011920929),
                          Color(0x000D0C0F)
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Color(0x33C9C9C9),
                              borderRadius: BorderRadius.circular(16)),
                          child: CustomText(
                            text:
                                "${categories.firstWhere((cat) => cat.id == event.categoryId).name}",
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CustomText(
                          text: event.title,
                          color: Colors.white,
                        ),
                        CustomText(
                          text: event.host,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16)),
                    color: inpBg,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CustomText(
                                  text: "Date",
                                  size: 12,
                                  color: hintColor,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                CustomText(
                                  text: event.eventDate,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 24,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                CustomText(
                                  text: "Time",
                                  size: 12,
                                  color: hintColor,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                CustomText(
                                  text: event.startTime,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width / 4,
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
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
    
    
    
    // Container(
    //   // margin: EdgeInsets.symmetric(horizontal: 8.0),
    //   width: MediaQuery.of(context).size.width,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(15),
    //     color: caroColor?? Colors.amber,
    //   ),
    //   child: Center(child: Text("data1"),),
    // );