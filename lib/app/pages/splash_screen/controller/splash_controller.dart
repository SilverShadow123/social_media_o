import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:social_media_o/routes/routes.dart';

class SplashController extends GetxController {
  /// Initialize Firebase and then navigate to the home screen.
  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      // After Firebase initialization, wait for a short delay and navigate.
      Future.delayed(const Duration(seconds: 3), () {
        if(FirebaseAuth.instance.currentUser != null) {
          // Navigate to the home screen if Firebase is initialized successfully.
          Get.offAllNamed(AppRoutes.home);
        } else {
          // If Firebase initialization failed, navigate to the login screen.
          Get.offAllNamed(AppRoutes.login);
        }

      });
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to initialize Firebase: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
