import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/forgot_password/forgot_password_controller.dart';
import 'package:flutter_getx_boilerplate/shared/shared.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white, // Changed to white
      appBar: AppBar(
        backgroundColor: Colors.white, // Changed to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Changed to black
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Forgot Your Password?',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Changed to black
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Enter your email or phone number to receive a confirmation code',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),

            // Email/Phone Toggle
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // Lighter grey for white theme
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _buildToggleButton('Email', true),
                  _buildToggleButton('Phone', false),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Email/Phone Input

            Obx(
              () => TextField(
                controller: controller.emailController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: controller.isEmailSelected.value
                      ? 'Enter your email'
                      : 'Enter your phone number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Obx(() => Icon(
                        controller.isEmailSelected.value
                            ? Icons.email_outlined
                            : Icons.phone_iphone_outlined,
                        color: ColorConstants.primaryGreen,
                      )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: controller.isEmailSelected.value
                    ? TextInputType.emailAddress
                    : TextInputType.number,
                onChanged: controller.onInputChanged,
              ),
            ),
            Obx(() => controller.emailError.value.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
                    child: Text(
                      controller.emailError.value,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  )
                : const SizedBox.shrink()),

            SizedBox(height: 20.h),

            // Reset Password Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        controller.isLoading.value ? null : controller.sendCode,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      backgroundColor:
                          ColorConstants.primaryGreen, // Keeping teal as accent
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('Reset Password',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16.sp)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isEmail) {
    return Obx(() => Expanded(
          child: Material(
            color: controller.isEmailSelected.value == isEmail
                ? ColorConstants.primaryGreen // Keeping teal as accent
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () => controller.toggleEmailPhone(isEmail),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: controller.isEmailSelected.value == isEmail
                        ? Colors.white
                        : Colors.black, // Changed to black
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
