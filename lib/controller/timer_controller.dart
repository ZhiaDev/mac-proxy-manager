import 'dart:async';
import 'package:get/get.dart';

class TimerController extends GetxController {
  // Observable for the timer value
  final _timerValue = 0.obs;
  // Observable to track if the timer is running
  final _isTimerRunning = false.obs;
  // Timer instance for the timer functionality
  late Timer _timer;

  // Getters to access timer value and running state
  int get timerValue => _timerValue.value;
  bool get isTimerRunning => _isTimerRunning.value;

  // Start the timer
  void startTimer() {
    if (!isTimerRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // Increment the timer value every second
        _timerValue.value++;
      });
      // Set the timer state to running
      _isTimerRunning.value = true;
    }
  }

  // Stop and reset the timer
  void stopTimer() {
    if (isTimerRunning) {
      // Cancel the timer
      _timer.cancel();
      // Set the timer state to not running
      _isTimerRunning.value = false;
      // Reset the timer value to 0
      _timerValue.value = 0;
    }
  }

  // Format the timer value into a string (HH:MM:SS)
  String formattedTimer() {
    int hours = (timerValue ~/ 3600);
    int minutes = (timerValue % 3600) ~/ 60;
    int seconds = (timerValue % 60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
