import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String imageURL;
  final String title;
  final String host;
  final String location;
  final String price;
  final String category;
  final DateTime eventDate;
  final DateTime startTime;
  final DateTime endTime;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String numOfTickets;

  Event({
    required this.id,
    required this.imageURL,
    required this.title,
    required this.host,
    required this.location,
    required this.price,
    required this.category,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.numOfTickets,
  });

  // Factory method to create Event from Firestore DocumentSnapshot
  factory Event.fromFirestore(Map<String, dynamic> data, String documentId) {
    // Helper function to convert Timestamp to DateTime
    DateTime? convertToDateTime(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      } else if (value is DateTime) {
        return value;
      } else if (value is String) {
        return DateTime.tryParse(value);
      }
      return null;
    }

    return Event(
      id: documentId,
      imageURL: data['imageURL'] ?? '',
      title: data['title'] ?? '',
      host: data['host'] ?? '',
      location: data['location'] ?? '',
      price: data['price'] ?? '',
      category: data['category'] ?? '',
      eventDate: convertToDateTime(data['eventDate']) ?? DateTime.now(),
      startTime: convertToDateTime(data['startTime']) ?? DateTime.now(),
      endTime: convertToDateTime(data['endTime']) ?? DateTime.now(),
      description: data['description'] ?? '',
      startDate: convertToDateTime(data['startDate']) ?? DateTime.now(),
      endDate: convertToDateTime(data['endDate']) ?? DateTime.now(),
      numOfTickets: data['numOfTickets'] ?? '',
    );
  }
}
