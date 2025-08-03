import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/repositories/verification_code_repository.dart';
import 'package:flutter_getx_boilerplate/modules/base/base_controller.dart';
import 'package:flutter_getx_boilerplate/routes/navigator_helper.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VerificationCodeController
    extends BaseController<VerificationCodeRepository> {
  VerificationCodeController(super.repository);

  // ✅ Replaced 4-digit controllers with single controller for Pinput
  final codeController = TextEditingController();
  final codeFocusNode = FocusNode();

  final countdown = 5.obs;
  final canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startCountdown();
  }

  void _startCountdown() {
    canResend.value = false;
    countdown.value = 5;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  void resendCode() {
    _startCountdown();
    Get.snackbar(
      'Success',
      'New verification code sent',
      backgroundColor: ColorConstants.primaryGreen,
    );
  }

  void verifyCode() {
    final code = codeController.text.trim();
    if (code.length == 4) {
      _showSuccessDialog();
      NavigatorHelper.toOnBoardScreen();
    } else {
      Get.snackbar(
        'Error',
        'Please enter complete 4-digit code',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _showSuccessDialog() async {
    return await Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 102.w,
              height: 102.h,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F7FA),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svgs/ic_done.svg',
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
              'Account verified! You can now log in and access all features.',
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
    _timer?.cancel();
    codeController.dispose();
    codeFocusNode.dispose();
    super.onClose();
  }
}
