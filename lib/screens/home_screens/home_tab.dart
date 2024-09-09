import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventure/controllers/categories_controller.dart';
import 'package:eventure/controllers/events_controller.dart';
import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/screens/event_screen.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:eventure/widgets/event_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});
  final EventsController eventsController = Get.put(EventsController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              eventsController.fetchEvents(),
              categoriesController.fetchCategories(),
            ]);
          },
          child: SingleChildScrollView(
            child: Obx(
              () {
                // empty state
                if (eventsController.eventsList.isEmpty) {
                  return Center(child: Text("No events available"));
                }

                // fulfilled state
                return Column(
                  children: [
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        LoginScreen(),
                                  ),
                                );
                              },
                              child: CustomText(
                                text: "Login",
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),

                    // banner
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => EventScreen(),
                          ),
                        );
                      },
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
                                      Colors.black
                                          .withOpacity(0.800000011920929),
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
                          )),
                    ),

                    //upcoming events
                    Container(
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
                    ),

                    SizedBox(
                      height: 24,
                    ),

                    // more events
                    Container(
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
                                EventContainer(),
                                EventContainer(),
                                EventContainer(),
                                EventContainer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
