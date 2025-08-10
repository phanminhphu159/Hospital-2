// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/shared/constants/constants.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF52D1C6),
              Color(0xFF30ADA2),
            ],
            begin: Alignment.topRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/images/safe_vax_logo.png'),
              ),
              SizedBox(height: 12.h),
              Text(
                controller.username.value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatCard(
                        iconPath: 'assets/svgs/ic_heart_beat.svg',
                        label: 'Heart rate',
                        value: controller.heartRate.value,
                      ),
                      VerticalDivider(
                        color: Colors.white.withOpacity(0.5),
                        thickness: 1,
                        width: 20.w,
                      ),
                      _StatCard(
                        iconPath: 'assets/svgs/ic_fire.svg',
                        label: 'Calories',
                        value: controller.calories.value,
                      ),
                      VerticalDivider(
                        color: Colors.white.withOpacity(0.5),
                        thickness: 1,
                        width: 20.w,
                      ),
                      _StatCard(
                        iconPath: 'assets/svgs/ic_barbell.svg',
                        label: 'Weight',
                        value: controller.weight.value,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.lightBackGround,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.h)),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _MenuItem(
                        icon: 'assets/svgs/ic_my_saved.svg',
                        title: 'My Saved',
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        height: 1,
                        thickness: 1,
                      ),
                      const _MenuItem(
                        icon: 'assets/svgs/ic_appointment.svg',
                        title: 'Appointment',
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        height: 1,
                        thickness: 1,
                      ),
                      const _MenuItem(
                        icon: 'assets/svgs/ic_payment_method.svg',
                        title: 'Payment Method',
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        height: 1,
                        thickness: 1,
                      ),
                      const _MenuItem(
                        icon: 'assets/svgs/ic_faqs.svg',
                        title: 'FAQs',
                      ),
                      SizedBox(height: 10.h),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        height: 1,
                        thickness: 1,
                      ),
                      const _MenuItem(
                        icon: 'assets/svgs/ic_log_out.svg',
                        title: 'Logout',
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;

  const _StatCard({
    required this.iconPath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(iconPath, width: 32.w, height: 32.h),
        SizedBox(height: 6.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.h),
      leading: SvgPicture.asset(icon, width: 43, height: 43),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
      onTap: () {
        // Handle menu action
      },
    );
  }
}
