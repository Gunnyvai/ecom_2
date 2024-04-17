import 'package:get/get.dart';

import '../controllers/detailedthriftproduct_controller.dart';

class DetailedthriftproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedthriftproductController>(
      () => DetailedthriftproductController(),
    );
  }
}
