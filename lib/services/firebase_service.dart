import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/models/event.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch events from Firestore
  Future<List<Event>> getEvents() async {
    try {
      QuerySnapshot snapshot = await _db.collection('events').get();
      return snapshot.docs.map((doc) {
        return Event.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching events: $e");
      return [];
    }
  }
}
