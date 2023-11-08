import 'dart:async';

class CountdownManager {
  static late Duration _countdownDuration;
  static late Timer countdownTimer;
  static late bool isCountdownActive;
  
    void startOneHourCountdown() {
    _countdownDuration = const Duration(hours: 1);
    isCountdownActive = true;

    countdownTimer = Timer(_countdownDuration, () {
      isCountdownActive = false;
      // Callback function or action to perform when the countdown ends
      print("Countdown completed");
    });
  }

  Duration getRemainingTime() {
    if (isCountdownActive) {
      return _countdownDuration - Duration(seconds: DateTime.now().second);
    } else {
      return Duration.zero;
    }
  }

  void cancelCountdown() {
    countdownTimer.cancel();
    isCountdownActive = false;
  }
}




 // bool onlongPress = true;




