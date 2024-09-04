import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:eventure/widgets/event_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              // login with avatar
              Container(
                height: 48,
                color: bgColor,
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/avatar_placeholder.svg",
                    ),
                    TextButton(
                        onPressed: () {},
                        child: CustomText(
                          text: "Login",
                          color: Colors.white,
                        ))
                  ],
                ),
              ),

              // banner
              Flexible(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.only(top: 24),
                      color: bgColor,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 224,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/events/omar_elgamal.jfif"),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            height: 224,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
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
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: CustomText(
                                    text: "Comedy",
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CustomText(
                                  text: "Ain Gamal",
                                  color: Colors.white,
                                ),
                                CustomText(
                                  text: "Omar El Gamal • Ahmed Amin",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),

              //upcoming events
              Flexible(
                  flex: 5,
                  child: Container(
                    color: bgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                        ),
                        CustomText(
                          text: "Upcoming Events",
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CarouselSlider(
                            items: <Widget>[
                              CarouselItem(
                                pic: "assets/images/events/kinglear.jfif",
                                eventCategory: "Drama",
                                eventPrice: "450",
                                title: "King Lear",
                                eventActors: "Yehia El Fakharany",
                                eventDate: "Sep 11",
                                eventTime: "09:00 PM",
                              ),
                              CarouselItem(
                                pic: "assets/images/events/omar_elgamal.jfif",
                                eventCategory: "Comedy",
                                eventPrice: "600",
                                title: "Ain Gamal",
                                eventActors: "Omar El Gamal • Ahmed Amin",
                                eventDate: "Sep 14",
                                eventTime: "10:00 PM",
                              ),
                              CarouselItem(
                                pic: "assets/images/events/memo.png",
                                eventCategory: "Comedy",
                                eventPrice: "750",
                                title: "Memo",
                                eventActors: "Ahmed Helmy",
                                eventDate: "Sep 20",
                                eventTime: "08:00 PM",
                              ),
                            ],
                            options: CarouselOptions(
                              height: 250,
                              enlargeCenterPage: true,
                              autoPlay: true,
                            )),

                        // ListView.builder(
                        //   scrollDirection: Axis.horizontal,
                        //   itemCount: 4,
                        //   itemBuilder: (context, int index)=> Container(
                        //     width: 100,
                        //     height: 100,
                        //     color: Colors.yellow,
                        //     child: Center(child: Text("data1")),
                        //   )
                        // )
                      ],
                    ),
                  )),

              // more events
              Flexible(
                  flex: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomText(
                          text: "More Events",
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   child: ListView.builder(
                        //     shrinkWrap: true,
                        //     itemCount: 4,
                        //     itemBuilder: (context, count) => EventContainer()
                        //   ),
                        // )

                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              EventContainer(),
                              // EventContainer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
