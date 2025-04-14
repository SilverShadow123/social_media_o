import 'package:get/get.dart';

import '../controller/graph_controller.dart';

class GraphBinding extends Bindings {
  @override
  void dependencies() {
    // Register the GraphController with GetX dependency injection
    Get.lazyPut(() => GraphController());
  }
}