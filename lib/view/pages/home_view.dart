import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

import '/view/widgets/appbar.dart';
import '/view/widgets/drawer.dart';
import '/controller/proxy_controller.dart';
import '/controller/timer_controller.dart';
import '/utils/custom_commands.dart';
import '/utils/custom_snackbar.dart';

// HomeView widget responsible for the main UI.
class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // Initialize controllers and variables
    final TimerController timerController = Get.put(TimerController());
    final ProxyController proxyController = Get.put(ProxyController());
    final player = AudioPlayer();
    final isConnected = RxBool(false);
    final tapScale = RxDouble(1);
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    ProcessResult httpProxyResult = ProcessResult(1, 2, 3, 4);
    ProcessResult httpsProxyResult = ProcessResult(1, 2, 3, 4);
    ProcessResult socksProxyResult = ProcessResult(1, 2, 3, 4);

    return Scaffold(
      key: _key,
      backgroundColor: const Color(0xFF0A0726),
      appBar: CustomAppBar(
        scaffoldKey: _key,
        isConnected: isConnected,
        title: title,
      ),
      drawer: CustomDrawer(scaffoldKey: _key),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: SizedBox(),
            flex: 4,
          ),
          Obx(
            () => Center(
              child: AnimatedScale(
                scale: tapScale.value,
                duration: const Duration(microseconds: 100),
                child: Container(
                  height: 172,
                  width: 172,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isConnected.value
                        ? const Color(0xFF362D95)
                        : const Color(0xFF4237B1),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 90,
                        color: isConnected.value
                            ? const Color(0xFF6354FF).withOpacity(0.6)
                            : const Color(0xFF6354FF).withOpacity(0.4),
                      ),
                    ],
                  ),
                  child: GetBuilder(
                    init: proxyController,
                    builder: (controller) {
                      return customButton(
                        tapScale,
                        timerController,
                        player,
                        isConnected,
                        context,
                        proxyController,
                        httpProxyResult,
                        httpsProxyResult,
                        socksProxyResult,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
            flex: 9,
          ),
        ],
      ),
    );
  }

  Widget customButton(
    RxDouble tapScale,
    TimerController timerController,
    AudioPlayer player,
    RxBool isConnected,
    BuildContext context,
    ProxyController proxyController,
    ProcessResult httpProxyResult,
    ProcessResult httpsProxyResult,
    ProcessResult socksProxyResult,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: GestureDetector(
          onTapDown: (details) {
            tapScale.value = 0.97;
          },
          onTapUp: (details) {
            tapScale.value = 1;
          },
          // Toggle the proxy connection on button tap
          onTap: () async {
            timerController.isTimerRunning
                // If the timer is running, stop it
                ? timerController.stopTimer()
                // If the timer is not running, start it
                : timerController.startTimer();
            await player.play(
              AssetSource('click-sound.mp3'),
              volume: 0.3,
            );
            if (isConnected.value) {
              // Disconnect from proxy
              try {
                CustomCommands.disableHTTPProxy();
                CustomCommands.disableHTTPSProxy();
                CustomCommands.disableSocksProxy();
              } catch (e) {
                CustomSnackBar.red(
                  context,
                  content: 'Error: $e',
                );
              }
              isConnected.value = false;
              CustomSnackBar.red(
                context,
                content: 'Disconnected',
              );
            } else if (!isConnected.value) {
              // Connect to proxy
              if (proxyController.httpModel.isEnabled.value) {
                httpProxyResult = await CustomCommands.enableHTTPProxy(
                  server: proxyController.httpModel.server.value,
                  port: proxyController.httpModel.port.value,
                );
              }
              if (proxyController.httpsModel.isEnabled.value) {
                httpsProxyResult = await CustomCommands.enableHTTPSProxy(
                  server: proxyController.httpsModel.server.value,
                  port: proxyController.httpsModel.port.value,
                );
              }
              if (proxyController.socksModel.isEnabled.value) {
                socksProxyResult = await CustomCommands.enableSocksProxy(
                  server: proxyController.socksModel.server.value,
                  port: proxyController.socksModel.port.value,
                );
              }

              if (!proxyController.httpModel.isEnabled.value &&
                  !proxyController.httpsModel.isEnabled.value &&
                  !proxyController.socksModel.isEnabled.value) {
                CustomSnackBar.red(context,
                    content: 'Error: Enable a proxy in Settings.');
              } else if (httpProxyResult.exitCode == 0 ||
                  httpsProxyResult.exitCode == 0 ||
                  socksProxyResult.exitCode == 0) {
                CustomSnackBar.green(context, content: 'Connected');
                isConnected.value = true;
              } else {
                CustomSnackBar.red(context,
                    content: 'Error: Unable to connect');
              }
            }
            await player.play(AssetSource('click-sound.mp3'), volume: 0.3);
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isConnected.value
                    ? [
                        const Color(0xFF5245D4),
                        const Color(0xFF292277),
                      ]
                    : [
                        const Color(0xFF0A0726),
                        const Color(0xFF0A0726),
                      ],
              ),
            ),
            child: Center(
              child: isConnected.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() {
                          return Text(
                            timerController.formattedTimer(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          );
                        }),
                        const Text(
                          'STOP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  : const Text(
                      'GO',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4237B1),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
