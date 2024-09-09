import 'package:eventure/models/event.dart';
import 'package:eventure/services/firebase_service.dart';
import 'package:get/get.dart';

class EventsController extends GetxController {
  var eventsList = <Event>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

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
      isLoading(false);
    }
  }
}
