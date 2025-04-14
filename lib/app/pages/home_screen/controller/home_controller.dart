import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../routes/routes.dart';
import '../widget/new_expanse_add.dart';

class HomeController extends GetxController{
  void onOpeningFloatingActionButton() {
    Get.dialog(
      NewExpanseAdd(),
    );
  }

  void logout() async{
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
  void navigateToEarned() {
    Get.toNamed(AppRoutes.earned);
  }
  void navigateToGraph() {
    Get.toNamed(AppRoutes.graph);
  }

  void navigateToHome() {
    Get.toNamed(AppRoutes.home);
  }

  void navigateToSpent() {
    Get.toNamed(AppRoutes.spent);
  }
  void navigateToProfile() {
    Get.toNamed(AppRoutes.profile);
  }
String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  String get email => FirebaseAuth.instance.currentUser?.email ?? '';
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

