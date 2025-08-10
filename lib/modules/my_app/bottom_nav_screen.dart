// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:get/get.dart';
import 'bottom_nav_controller.dart';

class BottomNavScreen extends GetView<BottomNavController> {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(() => Scaffold(
          body: Navigator(
            key: Get.nestedKey(1),
            onGenerateRoute: (settings) {
              return GetPageRoute(
                page: () => GetRouterOutlet(
                  initialRoute: controller.routes[controller.currentIndex.value],
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: ColorConstants.white,
            currentIndex: controller.currentIndex.value,
            selectedItemColor: const Color(0xFF00C6A2),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: controller.onBottomNavTap,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        ));
  }
}
