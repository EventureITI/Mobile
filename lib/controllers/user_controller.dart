import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/services/auth_service.dart';
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
    fName = fn.obs;
    lName = ln.obs;
  }

  void defaultData() {
    fName = "".obs;
    lName = "".obs;
  }
}
