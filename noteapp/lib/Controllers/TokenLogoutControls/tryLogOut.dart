import 'package:noteapp/Views/HomePage/export_home.dart';
import 'package:noteapp/Views/Logins/export_login_register.dart';


// ignore_for_file: use_build_context_synchronously
class LongOpenLogOutUser{
  LogOutService logOutService = LogOutService();
  LoginAndRegistrationControllers loginAndRegistrationControllers = LoginAndRegistrationControllers();
  
   // check for internet when app want to log user out
  Future<void> loginCheckInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      loginAndRegistrationControllers.internetSnackBar(context);
    } else {
      await logOutService.userLogOutIfTokenExpires(context);
    }
  }

}