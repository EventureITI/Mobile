import 'package:eventure/models/event.dart';
import 'package:eventure/services/firebase_service.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  // Observable lists for events
  RxBool isLoading = true.obs;
  RxList<Event> eventsList = <Event>[].obs;
  RxList<Event> categorizedEvents = <Event>[].obs;
  RxList<Event> filteredEvents = <Event>[].obs;
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  // Fetch events from Firestore (Firestore --> eventsList)
  void fetchEvents() async {
    isLoading(true);
    try {
      var events = await FirestoreService().getEvents();
      if (events.isNotEmpty) {
        eventsList.assignAll(events);
      }
    } catch (e) {
      print("Error fetching events: $e");
    } finally {
      categorizeEvents('all');
      isLoading(false);
    }
  }

  // Filter events based on selected category (eventsList --> categorizedEvents)
  void categorizeEvents(String categoryId) {
    if (categoryId == 'all') {
      categorizedEvents.assignAll(eventsList);
    } else {
      categorizedEvents.assignAll(
        eventsList.where((event) => event.category == categoryId).toList(),
      );
    }
    filterEvents();
  }

  // Filter events based on search query (categorizedEvents --> filteredEvents)
  void filterEvents() {
    String query = searchQuery.value.toLowerCase();

    if (query.isNotEmpty) {
      filteredEvents.value = categorizedEvents
          .where((event) => event.title.toLowerCase().contains(query))
          .toList();
    } else {
      filteredEvents.value = categorizedEvents;
    }
  }
}
