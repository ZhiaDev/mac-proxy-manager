import 'package:flutter/material.dart';
import '/utils/custom_snackbar.dart';
import 'package:get/get.dart';

import '../controller/proxy_controller.dart';

class SettingPage extends StatelessWidget {
  final ProxyController proxyController = Get.find<ProxyController>();

  // Initialize text controllers for input fields
  final TextEditingController httpServerEditingController = TextEditingController();
  final TextEditingController httpPortEditingController = TextEditingController();
  final TextEditingController httpsServerEditingController = TextEditingController();
  final TextEditingController httpsPortEditingController = TextEditingController();
  final TextEditingController socksServerEditingController = TextEditingController();
  final TextEditingController socksPortEditingController = TextEditingController();

  SettingPage({Key? key}) : super(key: key) {
    // Populate text controllers with initial values from the proxy controller
    httpServerEditingController.text = proxyController.httpModel.server.value;
    httpPortEditingController.text = proxyController.httpModel.port.value;
    httpsServerEditingController.text = proxyController.httpsModel.server.value;
    httpsPortEditingController.text = proxyController.httpsModel.port.value;
    socksServerEditingController.text = proxyController.socksModel.server.value;
    socksPortEditingController.text = proxyController.socksModel.port.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0726),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0726),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: const EdgeInsets.all(0),
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 4),
            child: ElevatedButton(
              onPressed: () {
                _saveSettings();
                // Display a green Snackbar when settings are saved
                CustomSnackBar.green(context, content: 'Saved'); 
              },
              child: Text(
                'Save',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              _buildInputField(
                context,
                "HTTP Proxy",
                httpServerEditingController,
                httpPortEditingController,
                proxyController.httpModel.isEnabled,
              ),
              _buildInputField(
                context,
                "HTTPS Proxy",
                httpsServerEditingController,
                httpsPortEditingController,
                proxyController.httpsModel.isEnabled,
              ),
              _buildInputField(
                context,
                "Socks Proxy",
                socksServerEditingController,
                socksPortEditingController,
                proxyController.socksModel.isEnabled,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildInputField(
    BuildContext context,
    String label,
    TextEditingController serverController,
    TextEditingController portController,
    RxBool isEnabled,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Spacer(),
              Obx(
                () => Transform.scale(
                  scale: 0.6,
                  child: Switch(
                    value: isEnabled.value,
                    onChanged: (newValue) {
                      proxyController.setSwitchValue(isEnabled, newValue);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                flex: 70,
                child: TextField(
                  enabled: isEnabled.value,
                  controller: serverController,
                  decoration: InputDecoration(
                    label: const Text('Server'),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 30,
                child: TextField(
                  enabled: isEnabled.value,
                  controller: portController,
                  decoration: InputDecoration(
                    label: const Text('Port'),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // Helper method to save the updated settings
  void _saveSettings() {
    proxyController.httpModel.server.value = httpServerEditingController.text;
    proxyController.httpModel.port.value = httpPortEditingController.text;
    proxyController.httpsModel.server.value = httpsServerEditingController.text;
    proxyController.httpsModel.port.value = httpsPortEditingController.text;
    proxyController.socksModel.server.value = socksServerEditingController.text;
    proxyController.socksModel.port.value = socksPortEditingController.text;
  }
}
