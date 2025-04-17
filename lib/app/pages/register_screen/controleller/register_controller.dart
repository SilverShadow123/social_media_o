import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../firebase/firestore/firestore.dart';
import '../../../../routes/routes.dart';


class RegisterController extends GetxController {
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onClose() {
    nameTEController.dispose();
    emailTEController.dispose();
    passwordTEController.dispose();
    confirmPasswordTEController.dispose();
    super.onClose();
  }

  void register() async {
    String name = nameTEController.text.trim();
    String email = emailTEController.text.trim();
    String password = passwordTEController.text.trim();
    String confirmPassword = confirmPasswordTEController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to Firestore
      String uid = userCredential.user!.uid;
      await _firestoreService.addUser(uid, name, email);

      Get.back(); // remove loading
      Get.toNamed(AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("Auth Error", e.message ?? "Unknown error");
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void navigateToLogin() {
    Get.back(canPop: true);
  }
}
