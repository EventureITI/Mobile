class Category {
  final String id;
  final String category;

  Category({
    required this.id,
    required this.category,
  });

  // Factory method to create Category from Firestore DocumentSnapshot
  factory Category.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Category(
      id: documentId,
      category: data['category'] ?? '',
    );
  }
}
