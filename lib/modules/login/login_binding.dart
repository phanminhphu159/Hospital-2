import 'package:flutter_getx_boilerplate/modules/login/login_controller.dart';
import 'package:flutter_getx_boilerplate/repositories/login_repository.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(
      () => LoginRepository(
        apiClient: Get.find(),
      ),
    );

    Get.lazyPut<LoginController>(
      () => LoginController(Get.find()),
    );
  }
}
