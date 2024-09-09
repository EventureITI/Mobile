import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/widgets/category_container.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventure/controllers/events_controller.dart';
import 'package:eventure/models/category.dart';
import 'package:eventure/services/firebase_service.dart';
import 'package:get/get.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final EventsController eventsController = Get.put(EventsController());
  final FirestoreService firestoreService = Get.put(FirestoreService());

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Search Field
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 24),
                    filled: true,
                    fillColor: inpBg,
                    hintText: "Search",
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    suffixIcon: SvgPicture.asset(
                      "assets/icons/search.svg",
                      fit: BoxFit.none,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: inpBg),
                        borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: inpBg),
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),

            SizedBox(height: 24),

            // Categories
            CustomText(
              text: "Categories",
              color: Colors.white,
            ),

            SizedBox(height: 16),

            // Category List
            SizedBox(
              height: 33,
              child: FutureBuilder<List<Category>>(
                future: firestoreService.getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No categories available'));
                  } else {
                    List<Category> categories = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        Category category = categories[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                              // eventsController.filterEventsByCategory(category.id); // Filter events
                            });
                          },
                          child: CategoryContainer(
                            catName: category.category,
                            activeClr: selectedCategoryIndex == index
                                ? btnColor
                                : null,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            SizedBox(height: 24),

            // Events Section (Carousel)
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: eventsController.filteredEvents.length,
                  itemBuilder: (context, index) {
                    // var event = eventsController.filteredEvents[index];
                    return CarouselItem(
                      contHeight: 300,
                      marginBtm: 8,
                      pic: "assets/images/events/kinglear.jfif",
                      eventCategory: "Drama",
                      eventPrice: "450",
                      title: "King Lear",
                      eventActors: "Yehia El Fakharany",
                      eventDate: "Sep 11",
                      eventTime: "09:00 PM",
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
