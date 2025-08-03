import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/repositories/login_repository.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_boilerplate/modules/base/base_controller.dart';
import 'package:flutter_getx_boilerplate/routes/navigator_helper.dart';

class LoginController extends BaseController<LoginRepository> {
  LoginController(super.repository);

  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable variables
  var passwordVisible = false.obs;
  var isEmailValid = true.obs;
  var isPasswordWrong = false.obs;
  var isLoading = false.obs;

  Color get emailBorderColor => isEmailValid.value ? Colors.grey : Colors.red;
  Color get passwordBorderColor => isPasswordWrong.value ? Colors.red : Colors.grey;


  // Email validation function
  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Login function
  Future<void> onLogin() async {
    try {
      isLoading(true);
      
      // Validate email
      isEmailValid.value = validateEmail(emailController.text);
      if (!isEmailValid.value) return;

      // Password validation (replace with real auth logic)
      isPasswordWrong.value = passwordController.text != "123456";
      if (isPasswordWrong.value) return;

      // If validation passes
      NavigatorHelper.toOnBoardScreen();
    } finally {
      isLoading(false);
    }
  }


  void toRegister()  {
      NavigatorHelper.toRegisterScreen();
  }

  void toForgotPasswordScreen()  {
      NavigatorHelper.toForgotPasswordScreen();
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
