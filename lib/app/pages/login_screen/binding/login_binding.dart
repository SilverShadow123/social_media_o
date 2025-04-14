import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  void dependencies() {
     Get.lazyPut<LoginController>(() => LoginController());
  }
}