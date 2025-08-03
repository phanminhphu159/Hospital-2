import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/veification_code/verification_code_controller.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends GetView<VerificationCodeController> {
  const VerificationCodeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Verification Code',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 16.sp),
                children: const [
                  TextSpan(
                    text: 'Enter code that we have sent to your number ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: '08528188***',
                    style: TextStyle(color: ColorConstants.primaryGreen),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),

            // 4-digit Code Input
            Center(
              child: Pinput(
                length: 4,
                controller:
                    controller.codeController, // Replace with your controller
                focusNode: controller.codeFocusNode, // Optional
                defaultPinTheme: PinTheme(
                  width: 64.w,
                  height: 64.h,
                  textStyle: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorConstants.primaryGreen, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 64.w,
                  height: 64.h,
                  textStyle: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorConstants.primaryGreen, width: 2.w),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onCompleted: (pin) {
                  controller.verifyCode();
                },
              ),
            ),
            SizedBox(height: 40.h),

            // Verify Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryGreen,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                ),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Resend Code
            Obx(
              () => Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // "Didn’t receive the code? ",
                      controller.canResend.value
                          ? 'Didn’t receive the code? '
                          : 'Resend code in ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.canResend.value
                          ? controller.resendCode
                          : null,
                      child: Text(
                        controller.canResend.value
                            ? 'Resend'
                            : '${controller.countdown.value}s',
                        style: TextStyle(
                          color: controller.canResend.value
                              ? ColorConstants.primaryGreen
                              : Colors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
