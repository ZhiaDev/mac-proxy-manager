import 'package:get/get.dart';

// Model for Bypass proxy list
class BypassModel {
  // Observable Bypass list
  final RxString bypassList = '*.local 169.254/16'.obs;
  // Observable for enabling/disabling
  final RxBool isEnabled = false.obs;
}
