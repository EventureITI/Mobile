import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Event {
  final String id;
  final String title;
  final String host;
  final String location;
  final String price;
  final String startTime;
  final String endTime;
  final String startDate;
  final String endDate;
  final String description;
  final bool isDeleted;
  final String imgUrl;
  final String categoryId;
  final String tickets;
  final String eventDate;

  Event({
    required this.id,
    required this.title,
    required this.host,
    required this.location,
    required this.price,
    required this.startTime,
    required this.endTime,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.isDeleted,
    required this.imgUrl,
    required this.categoryId,
    required this.tickets,
    required this.eventDate,
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

    DateTime fetchedStartTime =
        convertToDateTime(data['startTime']) ?? DateTime.now();
    DateTime fetchedEndTime =
        convertToDateTime(data['endTime']) ?? DateTime.now();
    DateTime fetchedStartDate =
        convertToDateTime(data['startDate']) ?? DateTime.now();
    DateTime fetchedEndDate =
        convertToDateTime(data['endDate']) ?? DateTime.now();
    DateTime fetchedEventDate =
        convertToDateTime(data['eventDate']) ?? DateTime.now();

    return Event(
      id: documentId,
      title: data['title'] ?? '',
      host: data['host'] ?? '',
      location: data['location'] ?? '',
      price: data['price'] ?? '',
      startTime: DateFormat('hh:mm a').format(fetchedStartTime),
      endTime: DateFormat('hh:mm a').format(fetchedEndTime),
      startDate: DateFormat('MMM dd').format(fetchedStartDate),
      endDate: DateFormat('MMM dd').format(fetchedEndDate),
      description: data['description'] ?? '',
      isDeleted: data['isDeleted'] ?? false,
      imgUrl: data['imgUrl'] ?? '',
      categoryId: data['categoryId'] ?? '',
      tickets: data['tickets'] ?? '',
      eventDate: DateFormat('MMM dd').format(fetchedEventDate),
    );
  }
}
