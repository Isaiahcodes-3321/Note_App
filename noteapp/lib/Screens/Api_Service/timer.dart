import 'dart:async';
import 'refreshTokenService.dart';


 
class CountdownManager {
  RefreshTokenService refreshTokenService = RefreshTokenService();
  Timer? _timer;

  void startTimerForRefreshToken() {
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      // Calculate the remaining time
      DateTime now = DateTime.now();
      DateTime oneHourLater = now.add(Duration(hours: 1));
      Duration remainingTime = oneHourLater.difference(now);

      // Check if there are 3 minutes remaining
      if (remainingTime.inMinutes == 3) {
        refreshTokenService.reFreshToken();
        timer.cancel();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
  }
}





 // bool onlongPress = true;




