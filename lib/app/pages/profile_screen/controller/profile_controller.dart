// profile_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../firebase/firestore/firestore.dart';




class ProfileController extends GetxController {

  final FirestoreService _firestoreService = FirestoreService();
  var isLoading = false.obs;

  // Get current user's UID
  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  // Get current user's email
  String get email => FirebaseAuth.instance.currentUser?.email ?? '';
  // Get current user's name
  String get name => FirebaseAuth.instance.currentUser?.displayName ?? '';



  @override
  void onInit() {
    super.onInit();
    // Add any initialization logic here if needed
    uid;
    email;
    name;
  }


}
