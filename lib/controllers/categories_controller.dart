import 'package:eventure/services/firestore_service.dart';
import 'package:get/get.dart';
import 'package:eventure/models/category.dart';

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
  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await FirestoreService().getCategories();
      if (fetchedCategories.isNotEmpty) {
        categoriesList.value = [
          Category(id: 'all', name: 'All'),
          ...fetchedCategories
        ];
        print("Categories fetched");
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
