import 'package:get/get.dart';

import '../controllers/detail_thrift_category_controller.dart';

class DetailThriftCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailThriftCategoryController>(
      () => DetailThriftCategoryController(),
    );
  }
}
