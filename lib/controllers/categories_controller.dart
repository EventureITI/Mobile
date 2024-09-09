import 'package:get/get.dart';
import 'package:eventure/models/category.dart';
import 'package:eventure/services/firebase_service.dart';

class CategoriesController extends GetxController {
  // Observable list for categories
  var categoriesList = <Category>[].obs;
  var selectedCategoryId = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch categories from Firestore
  void fetchCategories() async {
    try {
      var fetchedCategories = await FirestoreService().getCategories();
      if (fetchedCategories.isNotEmpty) {
        categoriesList.value = [
          Category(id: 'all', category: 'All'),
          ...fetchedCategories
        ];
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  // Select a category and notify listeners
  void selectCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
  }
}
