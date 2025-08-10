import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/modules/vaccination_management/vaccination_management_controller.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VaccinationManagementScreen
    extends GetView<VaccinationManagementController> {
  const VaccinationManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:  ColorConstants.lightBackGround, // Light background
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryGreen,
          toolbarHeight: 48, // Reduced from default 56
          title: const Text(
            'Vaccination',
            style: TextStyle(
              fontSize: 18, // Slightly smaller font
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48), // Reduced tab bar height
            child: Column(
              children: [
                const Divider(
                    height: 1, color: Colors.white24), // Subtle separator
                SizedBox(
                  height: 46, // Adjusted tab bar height
                  child: TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white.withOpacity(0.7),
                    indicatorColor: Colors.white,
                    indicatorWeight: 2, // Thinner indicator
                    labelStyle: const TextStyle(
                      fontSize: 14, // Smaller font for tabs
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(text: 'Schedule'),
                      Tab(text: 'History'),
                    ],
                    onTap: controller.changeTab,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Schedule Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.upcomingVaccinations.isNotEmpty) ...[
                        const Text(
                          'Upcoming Vaccinations',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF166534)),
                        ),
                        const SizedBox(height: 12),
                        ...controller.upcomingVaccinations
                            .asMap()
                            .entries
                            .map((entry) => VaccinationCard(
                                  vaccine: entry.value['vaccine'],
                                  date: entry.value['date'],
                                  time: entry.value['time'],
                                  center: entry.value['center'],
                                  dose: entry.value['dose'],
                                  status: entry.value['status'],
                                  onReschedule: () => controller
                                      .rescheduleVaccination(entry.key),
                                  onCancel: () =>
                                      controller.cancelVaccination(entry.key),
                                )),
                        const SizedBox(height: 24),
                      ],
                      const Text(
                        'Schedule New Vaccination',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF166534)),
                      ),
                      const SizedBox(height: 16),
                      ScheduleForm(controller: controller),
                    ],
                  )),
            ),

            // History Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Obx(() => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Vaccination History',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF166534)),
                          ),
                          TextButton.icon(
                            icon: const Icon(Icons.picture_as_pdf,
                                color: Color(0xFF16A34A)),
                            label: const Text('Export PDF',
                                style: TextStyle(color: Color(0xFF16A34A))),
                            onPressed: controller.exportToPDF,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (controller.vaccinationHistory.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(Icons.medical_services,
                                  size: 48, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              const Text(
                                'No vaccination history',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      else
                        ...controller.vaccinationHistory
                            .map((vaccination) => VaccinationHistoryCard(
                                  vaccine: vaccination['vaccine'],
                                  date: vaccination['date'],
                                  center: vaccination['center'],
                                  dose: vaccination['dose'],
                                  status: vaccination['status'],
                                )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleForm extends StatelessWidget {
  final VaccinationManagementController controller;
  const ScheduleForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Obx(
            () => DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Center',
                labelStyle: const TextStyle(color: Color(0xFF64748B)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon:
                    const Icon(Icons.location_on, color: Color(0xFF64748B)),
              ),
              value: controller.selectedCenter.value.isEmpty
                  ? null
                  : controller.selectedCenter.value,
              items: controller.centers.map((center) {
                return DropdownMenuItem(
                  value: center,
                  child: Text(center,
                      style: const TextStyle(color: Color(0xFF1E293B))),
                );
              }).toList(),
              onChanged: controller.selectCenter,
              validator: (value) =>
                  value == null ? 'Please select a center' : null,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    labelText: 'Select Vaccine',
                    labelStyle: const TextStyle(color: Color(0xFF64748B)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon:
                        const Icon(Icons.vaccines, color: Color(0xFF64748B))),
                value: controller.selectedVaccine.value.isEmpty
                    ? null
                    : controller.selectedVaccine.value,
                items: controller.vaccines.map((vaccine) {
                  return DropdownMenuItem(
                    value: vaccine,
                    child: Text(vaccine,
                        style: const TextStyle(color: Color(0xFF1E293B))),
                  );
                }).toList(),
                onChanged: controller.selectVaccine,
                validator: (value) =>
                    value == null ? 'Please select a vaccine' : null,
              )),
          const SizedBox(height: 16),
          Obx(() => TextFormField(
                decoration: InputDecoration(
                    labelText: 'Select Date',
                    labelStyle: const TextStyle(color: Color(0xFF64748B)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.calendar_today,
                        color: Color(0xFF64748B))),
                readOnly: true,
                controller: TextEditingController(
                  text: controller.selectedDate.value != null
                      ? DateFormat('MM/dd/yyyy')
                          .format(controller.selectedDate.value!)
                      : '',
                ),
                onTap: () => controller.selectDate(context),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a date'
                    : null,
              )),
          const SizedBox(height: 16),
          Obx(() => TextFormField(
                decoration: InputDecoration(
                    labelText: 'Select Time',
                    labelStyle: const TextStyle(color: Color(0xFF64748B)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.access_time,
                        color: Color(0xFF64748B))),
                readOnly: true,
                controller: TextEditingController(
                  text: controller.selectedTime.value != null
                      ? controller.selectedTime.value!.format(context)
                      : '',
                ),
                onTap: () => controller.selectTime(context),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a time'
                    : null,
              )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryGreen, // Primary green
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              onPressed: controller.submitSchedule,
              child: const Text(
                'SCHEDULE VACCINATION',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VaccinationCard extends StatelessWidget {
  final String vaccine;
  final String date;
  final String time;
  final String center;
  final String dose;
  final String status;
  final VoidCallback onReschedule;
  final VoidCallback onCancel;

  const VaccinationCard({
    super.key,
    required this.vaccine,
    required this.date,
    required this.time,
    required this.center,
    required this.dose,
    required this.status,
    required this.onReschedule,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.vaccines,
                  color: status == 'scheduled'
                      ? ColorConstants.primaryGreen // Green for scheduled
                      : const Color(0xFF059669), // Darker green for completed
                ),
                const SizedBox(width: 12),
                Text(
                  vaccine,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: status == 'scheduled'
                        ? const Color(0xFFDCFCE7) // Light green
                        : const Color(
                            0xFFD1FAE5), // Slightly darker light green
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status == 'scheduled' ? 'Scheduled' : 'Completed',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: status == 'scheduled'
                          ? const Color(0xFF166534) // Dark green
                          : const Color(0xFF065F46), // Darker green
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DetailRow(icon: Icons.calendar_today, text: '$date - $time'),
            const SizedBox(height: 8),
            DetailRow(icon: Icons.location_on, text: center),
            const SizedBox(height: 8),
            DetailRow(icon: Icons.medical_services, text: 'Dose: $dose'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReschedule,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: ColorConstants.primaryGreen,
                      side:
                          const BorderSide(color: ColorConstants.primaryGreen),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Reschedule'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VaccinationHistoryCard extends StatelessWidget {
  final String vaccine;
  final String date;
  final String center;
  final String dose;
  final String status;

  const VaccinationHistoryCard({
    super.key,
    required this.vaccine,
    required this.date,
    required this.center,
    required this.dose,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.vaccines,
                    color: Color(0xFF059669)), // Darker green for history
                const SizedBox(width: 12),
                Text(
                  vaccine,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B)),
                ),
                const Spacer(),
                Text(
                  DateFormat('MM/dd/yyyy').format(DateTime.parse(date)),
                  style:
                      const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DetailRow(icon: Icons.location_on, text: center),
            const SizedBox(height: 8),
            DetailRow(icon: Icons.medical_services, text: 'Dose: $dose'),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const DetailRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF64748B)),
        const SizedBox(width: 12),
        Text(text,
            style: const TextStyle(color: Color(0xFF475569), fontSize: 14)),
      ],
    );
  }
}
