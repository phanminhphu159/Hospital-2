// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_getx_boilerplate/shared/constants/colors.dart';
import 'package:flutter_getx_boilerplate/shared/utils/size_config.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    const Color primaryColor = Color(0xFF199A8E);
    const Color alertColor = Color(0xFFF44336);
    const Color warningColor = Color(0xFFFF9800);
    const Color infoColor = Color(0xFF2196F3);

    return Scaffold(
      backgroundColor: ColorConstants.lightBackGround,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  /// HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello, Lucas 👋",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87)),
                          const SizedBox(height: 4),
                          Text("Stay healthy & up to date",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey)),
                        ],
                      ),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: primaryColor.withOpacity(0.1),
                        backgroundImage:
                            const AssetImage("assets/images/safe_vax_logo.png"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// UPCOMING APPOINTMENT CARD
                  Obx(() => _AppointmentCard(
                        date: controller.upcomingAppointment.value,
                        time: "9:00 AM",
                        vaccine: "COVID-19 Booster",
                        doctor: "Dr. Sarah Johnson",
                        location: "Sky Health Clinic",
                      )),

                  const SizedBox(height: 24),

                  /// HEALTH STATS GRID
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _StatCard(
                        title: "Doses Taken",
                        icon: Icons.vaccines,
                        value: controller.dosesTaken.value,
                        color: primaryColor,
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacity(0.6),
                            primaryColor.withOpacity(0.9),
                          ],
                        ),
                        onTap: () {
                          controller.toVaccinationManagementScreen();
                        },
                      ),
                      _StatCard(
                        title: "Vaccines Due",
                        icon: Icons.warning_amber_rounded,
                        value: controller.vaccinesMissing.value,
                        color: warningColor,
                        gradient: LinearGradient(
                          colors: [
                            warningColor.withOpacity(0.6),
                            warningColor.withOpacity(0.9),
                          ],
                        ),
                        onTap: () {},
                      ),
                      _StatCard(
                        title: "Appointments",
                        icon: Icons.event_available,
                        value: "12",
                        color: infoColor,
                        gradient: LinearGradient(
                          colors: [
                            infoColor.withOpacity(0.6),
                            infoColor.withOpacity(0.9),
                          ],
                        ),
                        onTap: () {},
                      ),
                      _StatCard(
                        title: "Health Alerts",
                        icon: Icons.notifications_active,
                        value: "1",
                        color: alertColor,
                        gradient: LinearGradient(
                          colors: [
                            alertColor.withOpacity(0.6),
                            alertColor.withOpacity(0.9),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// NOTIFICATIONS SECTION
                  Row(
                    children: [
                      Text(
                        "Notifications",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text("View All"),
                      ),
                    ],
                  ),
                ]),
              ),
            ),

            /// NOTIFICATIONS LIST
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: Obx(() => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final notif = controller.notifications[index];
                        return _NotificationCard(
                          icon: notif['icon'] as IconData,
                          title: notif['title'] as String,
                          message: notif['message'] as String,
                          time: notif['time'] as String,
                          type: notif['type'] as String,
                        );
                      },
                      childCount: controller.notifications.length,
                    ),
                  )),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String date;
  final String time;
  final String vaccine;
  final String doctor;
  final String location;

  const _AppointmentCard({
    required this.date,
    required this.time,
    required this.vaccine,
    required this.doctor,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF199A8E), Color(0xFF2AB7C6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calendar_today,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                "Upcoming Appointment",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            date,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            "at $time",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
          ),
          const SizedBox(height: 16),
          _DetailRow(
            icon: Icons.medical_services,
            text: vaccine,
          ),
          const SizedBox(height: 8),
          _DetailRow(
            icon: Icons.person,
            text: doctor,
          ),
          const SizedBox(height: 8),
          _DetailRow(
            icon: Icons.location_on,
            text: location,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("View Details"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF199A8E),
                    backgroundColor: ColorConstants.lightBackGround,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Reschedule"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white.withOpacity(0.6)),
        const SizedBox(width: 12),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final Color color;
  final Gradient gradient;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.color,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: gradient,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(height: 16),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String time;
  final String type;

  const _NotificationCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
  });

  Color _getCardColor() {
    switch (type) {
      case 'alert':
        return const Color(0xFFFEEBEE);
      case 'warning':
        return const Color(0xFFFFF8E1);
      case 'info':
        return const Color(0xFFE3F2FD);
      default:
        return const Color(0xFFE8F5E9);
    }
  }

  Color _getIconColor() {
    switch (type) {
      case 'alert':
        return const Color(0xFFF44336);
      case 'warning':
        return const Color(0xFFFF9800);
      case 'info':
        return const Color(0xFF2196F3);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _getCardColor(),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _getIconColor().withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: _getIconColor()),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black, // Changed to black
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style:
                  const TextStyle(color: Colors.black87), // Changed to black87
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54, // Changed to black54
                  ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.black54, // Changed to black54
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: () {},
      ),
    );
  }
}
