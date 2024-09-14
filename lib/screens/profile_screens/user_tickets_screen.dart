import 'package:eventure/controllers/categories_controller.dart';
import 'package:eventure/controllers/events_controller.dart';
import 'package:eventure/models/event.dart';
import 'package:eventure/services/auth_service.dart';
import 'package:eventure/utils/text_colors.dart';
import 'package:eventure/widgets/carousel_item.dart';
import 'package:eventure/widgets/custom_text.dart';
import 'package:eventure/widgets/event_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTicketsScreen extends StatefulWidget {
  const UserTicketsScreen({super.key});

  @override
  State<UserTicketsScreen> createState() => _UserTicketsScreenState();
}

class _UserTicketsScreenState extends State<UserTicketsScreen> {
  final EventsController eventsController = Get.put(EventsController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final userLoggedEmail = FirebaseAuth.instance.currentUser?.email;
  final AuthService database = AuthService();
  List<dynamic> userEvents = [];
  List<dynamic> upcomingEvents = [];
  List<dynamic> completedEvents = [];
  RxList<dynamic> categories = [].obs;
  bool isLoading = true;

/* -------------------------------------------------------------------------- */
  void fetchUserData(String? email) async {
    Map<String, dynamic>? userData = await database.getUserDataByEmail(email);
    userEvents = userData?['events'] ?? [];

    filterUserEvents();
  }

  void filterUserEvents() {
    setState(
      () {
        for (var userEvent in userEvents) {
          var eventId = userEvent['id'];

          Event matchingEvent = eventsController.allEvents
              .firstWhere((event) => event.id == eventId);

          // Map<String, dynamic> matchingEvent = eventsController.allEvents
          //     .firstWhere((event) => event.id == eventId)
          //     .toMap();

          matchingEvent.price = userEvent["totalPrice"].toString();

          matchingEvent.isDeleted == true
              ? completedEvents.add(matchingEvent)
              : upcomingEvents.add(matchingEvent);
        }
        categories.assignAll(categoriesController.categoriesList);
        print(categories[1].id);
        isLoading = false;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(userLoggedEmail);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              )),
          title: CustomText(
            text: "Your Tickets",
            color: Colors.white,
            size: 22,
          ),
          centerTitle: true,
          backgroundColor: bgColor,
          bottom: TabBar(
              labelColor: selectedNav,
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              dividerHeight: 0,
              indicatorColor: selectedNav,
              unselectedLabelColor: unSelectednav,
              unselectedLabelStyle: TextStyle(fontSize: 16),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 1,
              tabs: [
                Tab(
                  text: "Upcoming",
                ),
                Tab(
                  text: "Completed",
                ),
              ]),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bgColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: upcomingEvents.isNotEmpty
                      ? upcomingEvents.map((event) {
                          return CarouselItem(
                            contHeight: 265,
                            marginBtm: 16,
                            event: event,
                            categories: categories,
                          );
                        }).toList()
                      : [
                          CustomText(
                            text: "No events found",
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                  // CarouselItem(
                  //   contHeight: 265,
                  // ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: bgColor,
              child: SingleChildScrollView(
                child: Column(
                  children: completedEvents.isNotEmpty
                      ? completedEvents.map((event) {
                          return EventContainer(
                            event: event,
                          );
                        }).toList()
                      : [
                          CustomText(
                            text: "No events found",
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
