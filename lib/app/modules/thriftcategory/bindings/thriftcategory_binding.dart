import 'package:get/get.dart';

import '../controllers/thriftcategory_controller.dart';

class ThriftcategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThriftcategoryController>(
      () => ThriftcategoryController(),
    );
  }
}
