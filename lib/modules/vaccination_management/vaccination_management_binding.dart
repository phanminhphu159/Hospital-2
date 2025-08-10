import 'package:flutter_getx_boilerplate/modules/vaccination_management/vaccination_management_controller.dart';
import 'package:flutter_getx_boilerplate/repositories/vaccination_management_repository.dart';
import 'package:get/get.dart';

class VaccinationManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VaccinationManagementRepository>(
      () => VaccinationManagementRepository(
        apiClient: Get.find(),
      ),
    );

    Get.lazyPut<VaccinationManagementController>(
      () => VaccinationManagementController(Get.find()),
    );
  }
}
