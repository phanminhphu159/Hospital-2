import 'package:flutter_getx_boilerplate/repositories/register_repository.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/base/base_controller.dart';

class RegisterController extends BaseController<RegisterRepository> {
  RegisterController(super.repository);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var passwordVisible = false.obs;
  var confirmPasswordVisible = false.obs;
  var agreeToTerms = false.obs;
  var isLoading = false.obs;

  // Error states
  var nameError = Rx<String?>(null);
  var emailError = Rx<String?>(null);
  var passwordError = Rx<String?>(null);
  var confirmPasswordError = Rx<String?>(null);

  // Validation functions
  bool validateEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    return password.length >= 6;
  }

  void validateForm() {
    // Reset errors
    nameError.value = null;
    emailError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null;

    // Name validation
    if (nameController.text.isEmpty) {
      nameError.value = 'Please enter your name';
    }

    // Email validation
    if (emailController.text.isEmpty) {
      emailError.value = 'Please enter your email';
    } else if (!validateEmail(emailController.text)) {
      emailError.value = 'Please enter a valid email';
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      passwordError.value = 'Please enter a password';
    } else if (!validatePassword(passwordController.text)) {
      passwordError.value = 'Password must be at least 6 characters';
    }

    // Confirm password validation
    if (confirmPasswordController.text.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
    } else if (passwordController.text != confirmPasswordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
    }
  }

  Future<void> signUp() async {
    validateForm();

    try {
      isLoading(true);
      validateForm();

      // if (nameError.value != null ||
      //     emailError.value != null ||
      //     passwordError.value != null ||
      //     confirmPasswordError.value != null ||
      //     !agreeToTerms.value) {
      //   return;
      // }

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Show success dialog
      await _showSuccessDialog();

      // Navigate to login
      // Get.offAllNamed('/login');
    } finally {
      isLoading(false);
    }

    try {
      isLoading(true);
      // Add your sign up logic here
      // await AuthService().signUp(...);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> _showSuccessDialog() async {
    return await Get.dialog(
      AlertDialog(
        backgroundColor: ColorConstants.primaryGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 102.w,
              height: 102.h,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F7FA), // Light blue background
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svgs/ic_done.svg', // ⬅️ Your SVG path here
                  width: 102.w,
                  height: 102.h,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Success',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Your account has been successfully registered',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: 183,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
