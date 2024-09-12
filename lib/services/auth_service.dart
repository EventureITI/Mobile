import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
          .collection('Users') // Replace with your collection name
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
}
