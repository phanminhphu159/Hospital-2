import 'package:flutter_getx_boilerplate/modules/dashboard/dashboard_controller.dart';
import 'package:flutter_getx_boilerplate/repositories/dashboard_repository.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepository(
        apiClient: Get.find(),
      ),
    );

    Get.lazyPut<DashboardController>(
      () => DashboardController(Get.find()),
    );
  }
}
