class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  // Factory method to create Category from Firestore DocumentSnapshot
  factory Category.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      name: data['name'] ?? '',
    );
  }
}
