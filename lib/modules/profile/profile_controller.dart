import 'package:flutter_getx_boilerplate/repositories/profile_repository.dart';
import 'package:flutter_getx_boilerplate/modules/base/base_controller.dart';
import 'package:get/get.dart';

class ProfileController
    extends BaseController<ProfileRepository> {
  ProfileController(super.repository);

 var username = 'Amelia Renata'.obs;
  var heartRate = '215bpm'.obs;
  var calories = '756cal'.obs;
  var weight = '103lbs'.obs;
}