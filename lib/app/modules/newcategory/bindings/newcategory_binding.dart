import 'package:get/get.dart';

import '../controllers/newcategory_controller.dart';

class NewcategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewcategoryController>(
      () => NewcategoryController(),
    );
  }
}
