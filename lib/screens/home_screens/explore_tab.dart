import 'package:eventure/controllers/categories_controller.dart';
import 'package:eventure/controllers/events_controller.dart';
import 'package:eventure/models/category.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/widgets/category_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final EventsController eventsController = Get.put(EventsController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  // Search controller
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      eventsController.searchQuery.value = searchController.text;
      eventsController.filterEvents();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            eventsController.fetchEvents(),
            categoriesController.fetchCategories(),
          ]);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: bgColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 24),

                // Search Field
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    controller: searchController,
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

                // Categories Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Horizontal scroll for categories
                    Container(
                      height: 33,
                      child: Obx(() {
                        // Categories empty state
                        if (categoriesController.categoriesList.isEmpty) {}

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesController.categoriesList.length,
                          itemBuilder: (context, index) {
                            Category category =
                                categoriesController.categoriesList[index];
                            bool isSelected =
                                categoriesController.selectedCategoryId.value ==
                                    category.id;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  categoriesController
                                      .selectCategory(category.id);
                                  eventsController
                                      .categorizeEvents(category.id);
                                });
                              },
                              child: CategoryContainer(
                                catName: category.name,
                                activeClr: isSelected ? btnColor : null,
                              ),
                            );
                          },
                        );
                      }),
                    ),

                    SizedBox(height: 24),

                    // Events list (filtered by selected category)
                    Obx(
                      () {
                        // Events empty state
                        if (eventsController.filteredEvents.isEmpty) {
                          return Center(child: Text('No events found'));
                        }

                        return Column(
                          children:
                              eventsController.filteredEvents.map((event) {
                            return CarouselItem(
                              contHeight: 265,
                              marginBtm: 16,
                              event: event,
                              categories: categoriesController.categoriesList,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
