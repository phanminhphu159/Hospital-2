import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/routes/navigator_helper.dart';
import 'package:flutter_getx_boilerplate/shared/shared.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initScreen();
  }

  _initScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    if (Platform.isIOS) {
      FlutterNativeSplash.remove();
    }
    final firstInstall = StorageService.firstInstall;
    await Future.delayed(const Duration(milliseconds: 300));
    if (firstInstall) {
      // NavigatorHelper.toOnBoardScreen();
      NavigatorHelper.toLogin();
    }

    final accessToken = StorageService.token;
    if (accessToken != null) {
      // NavigatorHelper.toHome();
      NavigatorHelper.toLogin();
    } else {
      // NavigatorHelper.toAuth();
      NavigatorHelper.toLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: ColorConstants.primaryGreen,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 186.w,
              height: 192.78.h,
              child: Image.asset(
                ImageConstants.appLogoPNG,
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'Vaccine Safety Simplified',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
