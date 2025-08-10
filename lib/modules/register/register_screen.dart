// lib/modules/auth/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/register/register_controller.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:get/get.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.lightBackGround,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () async {
              final hasUnsavedChanges =
                  controller.nameController.text.isNotEmpty ||
                      controller.emailController.text.isNotEmpty ||
                      controller.passwordController.text.isNotEmpty;

              if (!hasUnsavedChanges) {
                Get.back();
                return;
              }

              final shouldPop = await _showExitConfirmation(context);
              if (shouldPop) {
                Get.back();
              }
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),

                  // Name Field
                  Obx(
                    () => TextField(
                      controller: controller.nameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withValues(alpha: 0.2),
                        filled: true,
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                        errorText: controller.nameError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (_) => controller.nameError.value = null,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Email Field
                  Obx(
                    () => TextField(
                      controller: controller.emailController,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.withValues(alpha: 0.2),
                        filled: true,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        errorText: controller.emailError.value,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (_) => controller.emailError.value = null,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Password Field
                  Obx(() => TextField(
                        controller: controller.passwordController,
                        style: const TextStyle(color: Colors.black),
                        obscureText: !controller.passwordVisible.value,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.withValues(alpha: 0.2),
                          filled: true,
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.passwordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                controller.passwordVisible.toggle(),
                          ),
                          errorText: controller.passwordError.value,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (_) => controller.passwordError.value = null,
                      )),
                  SizedBox(height: 16.h),

                  // Confirm Password Field
                  Obx(() => TextField(
                        controller: controller.confirmPasswordController,
                        style: const TextStyle(color: Colors.black),
                        obscureText: !controller.confirmPasswordVisible.value,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.withValues(alpha: 0.2),
                          filled: true,
                          hintText: 'Confirm your password',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.confirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () =>
                                controller.confirmPasswordVisible.toggle(),
                          ),
                          errorText: controller.confirmPasswordError.value,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (_) =>
                            controller.confirmPasswordError.value = null,
                      )),
                  SizedBox(height: 16.h),

                  // Terms Checkbox
                  Obx(() => Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: controller.agreeToTerms.value,
                                onChanged: (value) =>
                                    controller.agreeToTerms(value),
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>(
                                        (states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors
                                        .white; // Filled color when checked
                                  }
                                  return Colors
                                      .transparent; // Empty when unchecked
                                }),
                                checkColor:
                                    Colors.black, // Color of the checkmark
                                side:
                                    WidgetStateBorderSide.resolveWith((states) {
                                  return const BorderSide(
                                    color: Colors.black, // Border color
                                  );
                                }),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: 'I agree to the ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
                                    children: [
                                      const TextSpan(
                                        text: 'Terms of Service',
                                        style: TextStyle(
                                          color: ColorConstants.primaryGreen,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' and ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                      const TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: ColorConstants.primaryGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  SizedBox(height: 24.h),

                  // Sign Up Button
                  Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.signUp(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.black)
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                      )),
                  SizedBox(height: 24.h),

                  // Already have an account? Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: ColorConstants.primaryGreen,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> _showExitConfirmation(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Discard changes?'),
      content: const Text(
          'You have unsaved changes. Are you sure you want to leave?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Discard'),
        ),
      ],
    ),
  );
  return result ?? false;
}
