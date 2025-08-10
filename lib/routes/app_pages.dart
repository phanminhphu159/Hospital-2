import 'package:flutter_getx_boilerplate/modules/dashboard/dashboard_binding.dart';
import 'package:flutter_getx_boilerplate/modules/dashboard/dashboard_screen.dart';
import 'package:flutter_getx_boilerplate/modules/forgot_password/forgot_password_binding.dart';
import 'package:flutter_getx_boilerplate/modules/forgot_password/forgot_password_screen.dart';
import 'package:flutter_getx_boilerplate/modules/login/login_binding.dart';
import 'package:flutter_getx_boilerplate/modules/login/login_screen.dart';
import 'package:flutter_getx_boilerplate/modules/my_app/bottom_nav_binding.dart';
import 'package:flutter_getx_boilerplate/modules/my_app/bottom_nav_screen.dart';
import 'package:flutter_getx_boilerplate/modules/profile/profile_binding.dart';
import 'package:flutter_getx_boilerplate/modules/profile/profile_screen.dart';
import 'package:flutter_getx_boilerplate/modules/register/register_binding.dart';
import 'package:flutter_getx_boilerplate/modules/register/register_screen.dart';
import 'package:flutter_getx_boilerplate/modules/home/home.dart';
import 'package:flutter_getx_boilerplate/modules/modules.dart';
import 'package:flutter_getx_boilerplate/modules/vaccination_management/vaccination_management_binding.dart';
import 'package:flutter_getx_boilerplate/modules/vaccination_management/vaccination_management_screen.dart';
import 'package:flutter_getx_boilerplate/modules/veification_code/verification_code_binding.dart';
import 'package:flutter_getx_boilerplate/modules/veification_code/verification_code_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    // splash and onboard
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      // children: [
      //   GetPage(
      //     name: Routes.onboard,
      //     page: () => const OnboardScreen(),
      //   ),
      // ],
    ),

    // auth
    // GetPage(
    //   name: Routes.auth,
    //   page: () => const AuthScreen(),
    //   binding: AuthBinding(),
    // ),
    GetPage(
      name: Routes.login,
      page: () =>  const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () =>  const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () =>  const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.verification,
      page: () =>  const VerificationCodeScreen(),
      binding: VerificationCodeBinding(),
    ),


    // home
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.bottomNav,
      page: () => const BottomNavScreen(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.vaccinationManagement,
      page: () => const VaccinationManagementScreen(),
      binding: VaccinationManagementBinding(),
    ),
  ];
}
