import 'package:get/get.dart';
import '/model/bypass_model.dart';

class BypassController extends GetxController {
  final BypassModel bypassModel = BypassModel();

  // Set the Bypass proxy list
  void setBypassProxyList(String bypassList) {
    bypassModel.bypassList.value = bypassList;
  }

  // Set the value of a boolean observable (RxBool)
  void setSwitchValue(RxBool oldValue, bool newValue) {
    oldValue.value = newValue;
  }
}
