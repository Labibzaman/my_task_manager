import 'package:get/get.dart';
import '../../data/models/userModels.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import 'authController.dart';

class LoginController extends GetxController {

  bool _loginInProgress = false;
  String _message = '';

  bool get LoginProgress => _loginInProgress;
  String get message => _message;

  Future<bool> login(String email, dynamic password) async {

    _loginInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.login,
        body: {"email": email, "password": password},
        isLogin: true);

    _loginInProgress = false;
    update();

    if (response.isSuccess) {

      await Get.find<AuthController>().SaveUserInformation(
        response.jsonResponse['token'],
        UserModel.fromJson(
          response.jsonResponse['data'],
        ),
      );
      return true;
    } else {
      if (response.statusCode == 401) {
        _message = 'password/email is inCorrect';
      } else {
        _message = 'Something went wrong';
      }
    }
    return false;
  }
}
