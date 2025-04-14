// profile_binding.dart
import 'package:get/get.dart';

import '../controller/profile_controller.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy-initialize the ProfileController so it's available when needed.
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
