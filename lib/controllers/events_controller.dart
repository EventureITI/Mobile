import 'package:eventure/models/event.dart';
import 'package:eventure/services/firebase_service.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  // final FirestoreService firestoreService = Get.find<FirestoreService>(); //!

  // Observable lists for events
  var eventsList = <Event>[].obs;
  var isLoading = true.obs;
  var filteredEvents = <Event>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  // Fetch events from Firestore
  void fetchEvents() async {
    isLoading(true);
    try {
      var events = await FirestoreService().getEvents();
      if (events.isNotEmpty) {
        eventsList.assignAll(events);
        filteredEvents.assignAll(events);
      }
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      isLoading(false);
    }
  }

  // Filter events based on selected category
  void filterEventsByCategory(String categoryId) {
    if (categoryId == 'all') {
      filteredEvents.assignAll(eventsList);
    } else {
      filteredEvents.assignAll(
        eventsList.where((event) => event.category == categoryId).toList(),
      );
    }
  }
}
