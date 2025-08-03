import 'package:flutter_getx_boilerplate/repositories/forgot_password_repository.dart';
import 'package:flutter_getx_boilerplate/routes/navigator_helper.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/base/base_controller.dart';

class ForgotPasswordController
    extends BaseController<ForgotPasswordRepository> {
  ForgotPasswordController(super.repository);
  final emailController = TextEditingController();
  final codeController = TextEditingController();

  var isEmailSelected = true.obs;
  var isLoading = false.obs;
  var emailError = ''.obs;

  void toggleEmailPhone(bool isEmail) {
    if (isEmailSelected.value != isEmail) {
      isEmailSelected.value = isEmail;
      emailController.clear();
      emailError.value = '';
    }
  }

  Future<void> sendCode() async {
    final input = emailController.text.trim();
    emailError.value = '';

    if (input.isEmpty) {
      emailError.value =
          'Please enter your ${isEmailSelected.value ? 'email' : 'phone number'}';
      return;
    }

    if (isEmailSelected.value) {
      if (!_validateEmail(input)) {
        emailError.value = 'Please enter a valid email address';
        return;
      }
    } else {
      if (!_validatePhone(input)) {
        emailError.value = 'Please enter a valid phone number';
        return;
      }
    }

    // Nếu hợp lệ thì clear lỗi
    emailError.value = '';

    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar(
        'Success',
        'Code sent to $input',
        backgroundColor: ColorConstants.primaryGreen,
      );
      NavigatorHelper.toVerificationCodeScreen();
    } finally {
      isLoading(false);
    }
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validatePhone(String phone) {
    final phoneRegex = RegExp(r'^\+?\d{7,15}$'); // Basic phone validation
    return phoneRegex.hasMatch(phone);
  }

  void onInputChanged(String value) {
    if (emailError.value.isNotEmpty) emailError.value = '';
  }

  Future<void> resetPassword() async {
    if (codeController.text.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid 6-digit code',
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      isLoading(true);
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed('/login');
      Get.snackbar(
        'Success',
        'Password reset successfully',
        backgroundColor: ColorConstants.primaryGreen,
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    codeController.dispose();
    super.onClose();
  }
}
