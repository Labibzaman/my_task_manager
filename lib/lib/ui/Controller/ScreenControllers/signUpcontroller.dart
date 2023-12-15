import 'package:get/get.dart';

import '../../../data/network_caller.dart';
import '../../../data/network_response.dart';
import '../../../data/utility/urls.dart';

class SignUpController extends GetxController{

  bool _signupInProgress= false;
  bool get signUpProgress => _signupInProgress;
  String get message => _message;
String _message = '';
  Future<bool> signUp (String email,String firstName, String lastNsme,dynamic Mobile,String password) async {

      _signupInProgress = true;
      update();
      final NetworkResponse response =
      await NetworkCaller()
          .postRequest(Urls.registration,body: {
        "email":email,
        "firstName":firstName,
        "lastName":lastNsme,
        "mobile":Mobile,
        "password":password,

      });
      _signupInProgress = false;
      update();
      if (response.isSuccess) {
        _message = 'Your Account has been created, login ';
        return true;
      } else {
          _message = 'Your Account has not created, failed ';
      }
      return false;
    }

  }
