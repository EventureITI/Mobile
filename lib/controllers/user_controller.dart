import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxString fName = "".obs;
  RxString lName = "".obs;

  RxBool signed = false.obs;

  void loggedIn() {
    signed = true.obs;
  }

  void loggedOut() {
    signed = false.obs;
  }

  void saveUserData(String fn, String ln) {
    fName.value = fn;
    lName.value = ln;
  }

  void defaultData() {
    fName = "".obs;
    lName = "".obs;
  }


  // ------------------ New Code ----------------------
  var profilePictureUrl = ''.obs;

  // Fetch profile picture by email from Firestore
  void fetchProfilePictureByEmail(String? email) async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      profilePictureUrl.value = userDoc['profilePictureUrl'] ?? '';
    }
  }

  // Update profile picture URL in the state
  void updateProfilePicture(String url) {
    profilePictureUrl.value = url;
  }
}
