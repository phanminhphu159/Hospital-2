import 'package:flutter_getx_boilerplate/routes/routes.dart';
import 'package:flutter_getx_boilerplate/shared/services/services.dart';
import 'package:get/get.dart';

class NavigatorHelper {
  static toOnBoardScreen() {
    // return Get.offNamed(Routes.onboard);
    return Get.offAllNamed(Routes.splash);
  }

  static toAuth() {
    StorageService.clear();
    return Get.offNamed(Routes.auth);
  }

  static toLoginScreen() {
    StorageService.clear();
    return Get.offNamed(Routes.login);
  }

  static toRegisterScreen() {
    return Get.toNamed(Routes.register);
  }

  static toForgotPasswordScreen() {
    return Get.toNamed(Routes.forgotPassword);
  }

  static toVerificationCodeScreen() {
    return Get.toNamed(Routes.verification);
  }

  static toHomeScreen() {
    return Get.offNamed(Routes.home);
  }
}
