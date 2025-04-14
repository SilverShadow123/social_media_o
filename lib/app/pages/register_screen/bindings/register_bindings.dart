import 'package:get/get.dart';

import '../controleller/register_controller.dart';

class RegisterBindings extends Bindings {
  @override
  void dependencies() {
    // Register the RegisterController with GetX dependency injection
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}