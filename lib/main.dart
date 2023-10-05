import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green, brightness: Brightness.dark),
      ),
      home: const MyHomePage(title: 'Mac Proxy Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isConnected = false;
  int _timerValue = 0;
  bool _isTimerRunning = false;
  late Timer _timer;

  void _startTimer() {
    if (!_isTimerRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _timerValue++;
        });
      });
      setState(() {
        _isTimerRunning = true;
      });
    }
  }

  void _stopTimer() {
    if (_isTimerRunning) {
      _timer.cancel();
      setState(() {
        _isTimerRunning = false;
        _timerValue = 0; // Reset the timer value to 0 when stopped.
      });
    }
  }

  String _formattedTimer() {
    int hours = (_timerValue ~/ 3600);
    int minutes = (_timerValue % 3600) ~/ 60;
    int seconds = (_timerValue % 60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232C3D),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            const SizedBox(width: 8),
            isConnected
                ? SvgPicture.asset(
                    'assets/connect.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onBackground,
                      BlendMode.srcIn,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/disconnect.svg',
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onBackground,
                      BlendMode.srcIn,
                    ),
                  ),
            const SizedBox(width: 8),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 28),
            const SizedBox(
              height: 96,
              width: 96,
              child: CircleAvatar(),
            ),
            const Text('Parsa Sharifi', style: TextStyle(fontSize: 24)),
            Text(
              '@ZhiaDev',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32,
                  width: 32,
                  child: IconButton.outlined(
                    onPressed: () {},
                    splashRadius: 90,
                    padding: const EdgeInsets.all(0),
                    icon: SizedBox(
                      height: 20,
                      child: SvgPicture.asset(
                        'assets/instagram.svg',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: IconButton.outlined(
                    onPressed: () {},
                    splashRadius: 90,
                    padding: const EdgeInsets.all(0),
                    icon: SizedBox(
                      height: 22,
                      child: SvgPicture.asset(
                        'assets/github.svg',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: IconButton.outlined(
                    onPressed: () {},
                    splashRadius: 90,
                    padding: const EdgeInsets.all(0),
                    icon: SizedBox(
                      height: 20,
                      child: SvgPicture.asset(
                        'assets/coffee.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                      label: const Text('Setting'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.errorContainer,
                          shadowColor: Theme.of(context).colorScheme.error,
                          foregroundColor: Theme.of(context).colorScheme.error),
                      onPressed: () {
                        exit(0);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      label: Text(
                        'Quit',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: SizedBox(),
            flex: 4,
          ),
          Center(
            child: Container(
                height: 165,
                width: 165,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isConnected
                        ? [
                            Colors.limeAccent.shade700,
                            Colors.greenAccent.shade700
                          ]
                        : [Colors.grey.shade400, Colors.grey.shade700],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          _isTimerRunning ? _stopTimer() : _startTimer();
                          if (isConnected) {
                            setState(() {
                              isConnected = false;
                              // _stopTimer();
                            });
                          } else if (!isConnected) {
                            setState(() {
                              isConnected = true;
                              // _isTimerRunning ? _stopTimer : _startTimer;
                              // _startTimer();
                            });
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF232C3D),
                          ),
                          child: Center(
                            child: isConnected
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        _formattedTimer(),
                                        style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      const Text(
                                        'STOP',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF79D54D),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text(
                                    'GO',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF65CD55),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          const Expanded(
            child: SizedBox(),
            flex: 6,
          ),
        ],
      ),
    );
  }
}
