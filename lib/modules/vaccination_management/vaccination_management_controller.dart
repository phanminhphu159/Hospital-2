import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/base/base_controller.dart';
import 'package:flutter_getx_boilerplate/repositories/vaccination_management_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VaccinationManagementController extends BaseController<VaccinationManagementRepository> {
  VaccinationManagementController(super.repository);

  final RxInt selectedTab = 0.obs;
  final RxString selectedCenter = ''.obs;
  final RxString selectedVaccine = ''.obs;
  final Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final List<String> centers = [
    'Sky Health Clinic',
    'City Medical Center',
    'Community Health Hub',
    'Family Medical Practice'
  ];

  final List<String> vaccines = [
    'COVID-19 Pfizer',
    'COVID-19 Moderna',
    'Influenza',
    'HPV',
    'Hepatitis B',
    'Tetanus'
  ];

  final RxList<Map<String, dynamic>> vaccinationHistory = <Map<String, dynamic>>[
    {
      'vaccine': 'COVID-19 Pfizer',
      'date': '2023-10-15',
      'center': 'Sky Health Clinic',
      'dose': 'Booster',
      'status': 'completed'
    },
    {
      'vaccine': 'Influenza',
      'date': '2023-05-20',
      'center': 'City Medical Center',
      'dose': 'Annual',
      'status': 'completed'
    },
    {
      'vaccine': 'HPV',
      'date': '2023-01-10',
      'center': 'Women Health Center',
      'dose': '2/3',
      'status': 'completed'
    },
  ].obs;

  final RxList<Map<String, dynamic>> upcomingVaccinations = <Map<String, dynamic>>[
    {
      'vaccine': 'COVID-19 Moderna',
      'date': '2023-11-20',
      'time': '09:00 AM',
      'center': 'Sky Health Clinic',
      'dose': 'Booster',
      'status': 'scheduled'
    },
  ].obs;

  void changeTab(int index) => selectedTab.value = index;

  void selectCenter(String? value) => selectedCenter.value = value ?? '';

  void selectVaccine(String? value) => selectedVaccine.value = value ?? '';

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      selectedDate.value = picked;
      dateController.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value ?? TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTime.value = picked;
      timeController.text = picked.format(context);
    }
  }

  void rescheduleVaccination(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text('Reschedule Vaccination'),
        content: const Text('Are you sure you want to reschedule this vaccination?'),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Success', 'Vaccination rescheduled');
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void cancelVaccination(int index) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Vaccination'),
        content: const Text('Are you sure you want to cancel this vaccination?'),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              upcomingVaccinations.removeAt(index);
              Get.back();
              Get.snackbar('Success', 'Vaccination cancelled');
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void exportToPDF() {
    Get.snackbar('Info', 'Exporting to PDF...');
    // Add PDF export logic here
  }

  void submitSchedule() {
    if (selectedCenter.value.isEmpty ||
        selectedVaccine.value.isEmpty ||
        selectedDate.value == null ||
        selectedTime.value == null) {
      Get.snackbar('Error', 'Please fill all required fields');
      return;
    }

    final newVaccination = {
      'vaccine': selectedVaccine.value,
      'date': DateFormat('yyyy-MM-dd').format(selectedDate.value!),
      'time': selectedTime.value!.format(Get.context!),
      'center': selectedCenter.value,
      'dose': '1/1',
      'status': 'scheduled'
    };

    upcomingVaccinations.add(newVaccination);
    Get.snackbar('Success', 'Vaccination scheduled successfully');

    // Reset form and controllers
    selectedCenter.value = '';
    selectedVaccine.value = '';
    selectedDate.value = null;
    selectedTime.value = null;
    dateController.text = '';
    timeController.text = '';
  }

  // 4. Dispose controllers properly when controller is closed
  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }
}
