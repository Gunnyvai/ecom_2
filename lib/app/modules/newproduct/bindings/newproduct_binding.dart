import 'package:get/get.dart';

import '../controllers/newproduct_controller.dart';

class NewproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewproductController>(
      () => NewproductController(),
    );
  }
}
