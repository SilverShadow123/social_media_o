import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';

class LoginController extends GetxController{
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();

@override
  void onClose() {
    // TODO: implement onClose
    emailTEController.dispose();
    passwordTEController.dispose();
    super.onClose();
  }
  void login() async{
    String email = emailTEController.text.trim();
    String password = passwordTEController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
    try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    Get.offAllNamed(AppRoutes.home);
    print("Login button pressed");}
        on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Get.snackbar('Error', 'No user found for that email.');
          } else if (e.code == 'wrong-password') {
            Get.snackbar('Error', 'Wrong password provided for that user.');
          } else {
            Get.snackbar('Error', 'An error occurred. Please try again.');
          }
        } catch (e) {
          Get.snackbar('Error', 'An error occurred. Please try again.');

        }
  }
  void navigateToRegister() {
    // Implement your register logic here
    Get.toNamed(AppRoutes.register);
    print("Register button pressed");
  }

}