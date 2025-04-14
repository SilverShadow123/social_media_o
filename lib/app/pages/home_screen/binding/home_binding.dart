import 'package:get/get.dart';
import 'package:social_media_o/app/pages/home_screen/controller/expense_controller.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ExpenseController>(() => ExpenseController());
  }
}