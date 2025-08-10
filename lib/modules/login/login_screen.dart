// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/login/login_controller.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.lightBackGround,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 56.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.black),
                controller: controller.emailController,
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
                  suffixIcon: Obx(() => controller.isEmailValid.value
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.error, color: Colors.red)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: controller.isEmailValid.value
                        ? const BorderSide(color: Colors.grey)
                        : const BorderSide(color: Colors.red),
                  ),
                ),
                onChanged: (value) {
                  controller.isEmailValid.value =
                      controller.validateEmail(value);
                },
              ),
              Obx(() => !controller.isEmailValid.value
                  ? Padding(
                      padding: EdgeInsets.only(top: 8.0.h),
                      child: Text(
                        '*Please enter a valid email',
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    )
                  : const SizedBox.shrink()),
              SizedBox(height: 16.h),
              Obx(() => TextField(
                    controller: controller.passwordController,
                    obscureText: !controller.passwordVisible.value,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      prefixIcon:
                          const Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () => controller.passwordVisible.toggle(),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: controller.passwordBorderColor,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: controller.passwordBorderColor,
                          width: 1.0,
                        ),
                      ),
                    ),
                  )),
              Obx(() => controller.isPasswordWrong.value
                  ? Padding(
                      padding: EdgeInsets.only(top: 8.0.h),
                      child: Text(
                        '*The password you entered is wrong',
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    )
                  : const SizedBox.shrink()),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    controller.toForgotPasswordScreen();
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: ColorConstants.primaryGreen),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => controller.onLogin(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.toRegister();
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: ColorConstants.primaryGreen),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.h),
                    child: const Text(
                      "OR",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20.h),
              SignInButton(
                Buttons.Google,
                text: "Sign in with Google",
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 8.h),
              SignInButton(
                Buttons.AppleDark,
                text: "Sign in with Apple",
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              SizedBox(height: 8.h),
              SignInButton(
                Buttons.Facebook,
                text: "Sign in with Facebook",
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
