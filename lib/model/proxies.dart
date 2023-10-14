import 'package:get/get.dart';

// Model for HTTP proxy basic configuration
class HTTPModel {
  // Observable server address
  final RxString server = "127.0.0.1".obs;
  // Observable port
  final RxString port = "8080".obs;
  // Observable for enabling/disabling this proxy
  final RxBool isEnabled = false.obs;
}

// Model for HTTPS proxy basic configuration
class HTTPSModel {
  // Observable server address
  final RxString server = "127.0.0.1".obs;
  // Observable port
  final RxString port = "8080".obs;
  // Observable for enabling/disabling this proxy
  final RxBool isEnabled = false.obs;
}

// Model for SOCKS proxy basic configuration
class SocksModel {
  // Observable server address
  final RxString server = "127.0.0.1".obs;
  // Observable port
  final RxString port = "8080".obs;
  // Observable for enabling/disabling this proxy
  final RxBool isEnabled = false.obs;
}
