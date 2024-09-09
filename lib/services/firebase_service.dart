import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/models/category.dart';
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

  // Fetch categories from Firestore
  Future<List<Category>> getCategories() async {
    try {
      QuerySnapshot snapshot = await _db.collection('categories').get();
      return snapshot.docs.map((doc) {
        return Category.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }
}
