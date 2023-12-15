import 'package:get/get.dart';

import '../../../data/network_caller.dart';
import '../../../data/network_response.dart';
import '../../../data/utility/urls.dart';
import '../../screens/login_screen.dart';

class ConfirmPasswordController extends GetxController{
bool _inProgress = false;

bool get inProgress =>_inProgress;
String get message=> _message;

String _message = '';
  Future<void> confirmPassword(String email,dynamic Otp,String password) async {

      _inProgress = true;
     update();
      final NetworkResponse response = await NetworkCaller()
          .postRequest(Urls.recoverResetPassword, body: {
        "email":email,
        "OTP": Otp,
        "password": password
      });
      _inProgress=false;
     update();
      if (response.isSuccess) {

          _message= 'PassWord changed ';

          Get.offAll(const loginScreen());

      } else {
         _message = 'Password changed failed';
      }
      _inProgress=false;
     update();
    }
}