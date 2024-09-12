import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventure/controllers/categories_controller.dart';
import 'package:eventure/controllers/events_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/screens/auth_screens/firebase_auth_impl/user_controller.dart';
import 'package:eventure/screens/auth_screens/login_screen.dart';
import 'package:eventure/screens/event_screen.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:eventure/widgets/event_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});
  final EventsController eventsController = Get.put(EventsController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    // thereIsEmail();
    // print("from builddddd user fireStore Id is $userId");
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
                final eventsList = eventsController.eventsList;
                final categoriesList = categoriesController.categoriesList;

                // empty state
                if (eventsList.isEmpty) {
                  return Center(child: Text("No events available"));
                }

                // fulfilled state
                return Column(
                  children: [
                    // login with avatar

                    Container(
                        height: 48,
                        color: bgColor,
                        child: Obx(() => userController.signed.value == false
                            ? Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/avatar_placeholder.svg",
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(() => LoginScreen());
                                      },
                                      child: CustomText(
                                        text: "Login",
                                        color: Colors.white,
                                      ))
                                ],
                              )
                            : Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    "assets/icons/avatar_placeholder.svg",
                                  ),
                                ],
                              ))
                        // authUser == null ?

                        //
                        // :

                        ),

                    // banner
                    GestureDetector(
                      onTap: () {
                        Get.to(() => EventScreen(), arguments: eventsList[0]);
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
                                  image: NetworkImage(eventsList[0].imgUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                              child: eventsList.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Color(0x33C9C9C9),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: CustomText(
                                            text: categoriesList
                                                .firstWhere((cat) =>
                                                    cat.id ==
                                                    eventsList[0].categoryId)
                                                .name,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        CustomText(
                                          text: eventsList[0].title,
                                          color: Colors.white,
                                        ),
                                        CustomText(
                                          text: eventsList[0].host,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // upcoming events
                    Container(
                      color: bgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 24),
                          CustomText(
                            text: "Upcoming Events",
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          CarouselSlider(
                            items: eventsList.length >= 3
                                ? [
                                    for (int i = 1; i <= 3; i++)
                                      CarouselItem(
                                        event: eventsList[i],
                                        categories: categoriesList,
                                      ),
                                  ]
                                : [],
                            options: CarouselOptions(
                              height: 250,
                              enlargeCenterPage: true,
                              autoPlay: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // more events
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomText(
                            text: "More Events",
                            color: Colors.white,
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                for (int i = 4;
                                    i < 7 && i < eventsList.length;
                                    i++)
                                  EventContainer(
                                    event: eventsList[i],
                                  ),
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
