import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventure/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

UserController userControlling = Get.put(UserController());

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      print("error occured");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("error occured");
    }
    return null;
  }

  Future<Map<String, dynamic>?> getUserDataByEmail(String? email) async {
    try {
      // Query Firestore to get the user data based on the email field
      QuerySnapshot querySnapshot = await _db
          .collection('users') // Replace with your collection name
          .where('email', isEqualTo: email)
          .limit(1) // Limit to 1 to ensure only one document is retrieved
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No user found with the given email.');
        return null;
      }

      // Get the user data from the first document in the query results
      DocumentSnapshot userDoc = querySnapshot.docs.first;

      // Return the user data as a Map
      return userDoc.data() as Map<String, dynamic>?;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<void> updateUserProfileByEmail(
      String? email, String firstName, String lastName) async {
    // Query Firestore to get the user by email
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    // Check if user exists
    if (userSnapshot.docs.isNotEmpty) {
      // Assuming that email is unique and there's only one user with this email
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      DocumentReference userRef = userDoc.reference;

      // Update the first name and last name
      await userRef.update({
        'firstName': firstName,
        'lastName': lastName,
      });
      print('Profile updated successfully');
      userControlling.saveUserData(firstName, lastName);
    } else {
      print('User not found with this email');
    }
  }

  Future<void> addUserEventByEmail(
      String? email, Map<String, dynamic> newEvent) async {
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (userSnapshot.docs.isNotEmpty) {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      DocumentReference userRef = userDoc.reference;

      // Retrieve current events
      List<dynamic> currentEvents = userDoc.get('events') ?? [];

      // Add new event
      currentEvents.add(newEvent);

      await userRef.update({
        'events': currentEvents,
      });

      print('Event added successfully');
    } else {
      print('User not found with this email');
    }
  }

  Future<void> updateUserPassword(
      String email, String oldPassword, String newPassword) async {
    try {
      // Sign in the user to re-authenticate (required for password updates)
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      // If re-authentication is successful, update the password
      User? user = userCredential.user;
      await user!.updatePassword(newPassword);
      print('Password updated successfully');
    } catch (e) {
      print('Failed to update password: $e');
    }
  }
}
