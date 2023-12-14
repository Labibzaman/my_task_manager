import 'package:get/get.dart';

import '../../../data/network_caller.dart';
import '../../../data/network_response.dart';
import '../../../data/utility/urls.dart';
import '../../screens/pin_verify_screen.dart';

class ForgetController extends GetxController {
  bool _inProgress = false;
  String _message = '';

  bool get inProgress => _inProgress;

  String get message => _message;

  Future<bool> getVerifyemail(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    _message = "Please wait for confirmation";

    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.verifyEmail(email));
    _inProgress = false;
    update();
    if (response.isSuccess) {
      Get.to(Pin_verify_screen(email: email));


      return isSuccess = true;
    } else {
      _message = 'Enter correct email';
    }

    return isSuccess;
  }
}
