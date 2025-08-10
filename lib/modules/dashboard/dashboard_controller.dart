import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/base/base_controller.dart';
import 'package:flutter_getx_boilerplate/repositories/dashboard_repository.dart';
import 'package:flutter_getx_boilerplate/routes/navigator_helper.dart';
import 'package:get/get.dart';

class DashboardController extends BaseController<DashboardRepository> {
  DashboardController(super.repository);
  var dosesTaken = '3 doses'.obs;
  var vaccinesMissing = '2 vaccines'.obs;
  final upcomingAppointment = "Aug 12, 2025".obs;
  final upcomingTime = "9:00 AM".obs;
  final upcomingVaccine = "COVID-19 Booster".obs;
  final upcomingDoctor = "Dr. Sarah Johnson".obs;
  final upcomingLocation = "Sky Health Clinic".obs;

  // Update notifications to include type and time
  final notifications = <Map<String, dynamic>>[
    {
      'icon': Icons.calendar_today,
      'title': 'New Appointment',
      'message': 'You have a vaccine appointment on Aug 12 at 9:00 AM',
      'time': '10 min ago',
      'type': 'info',
    },
    {
      'icon': Icons.medical_services,
      'title': 'New Vaccine Available',
      'message': 'A new COVID-19 vaccine from Pfizer is now available',
      'time': '1 hour ago',
      'type': 'info',
    },
    {
      'icon': Icons.warning,
      'title': 'Health Alert',
      'message': 'Dengue outbreak reported in your area',
      'time': '2 days ago',
      'type': 'alert',
    },
  ].obs;


  void toVaccinationManagementScreen()  {
    NavigatorHelper.toVaccinationManagementScreen();
  }
}