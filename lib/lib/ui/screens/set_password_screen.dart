import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/data/network_caller.dart';
import 'package:task_manager_app/lib/data/network_response.dart';
import 'package:task_manager_app/lib/data/utility/urls.dart';

import '../widgets/body_background.dart';
import '../widgets/snack_message.dart';
import 'login_screen.dart';

class Set_password_screen extends StatefulWidget {
  Set_password_screen({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<Set_password_screen> createState() => _Set_password_screenState();
}

class _Set_password_screenState extends State<Set_password_screen> {
  TextEditingController newpassword = TextEditingController();
  TextEditingController Confirmpassword = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Set Password',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Password shoud be minimum 8 letters',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: newpassword,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'New password'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: Confirmpassword,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter same Password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'confirm password'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: inProgress ==false,
                        replacement: const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: confirmPassword,
                          child: const Text('Confirm'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Have an Account ?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return const loginScreen();
                            }), (route) => false);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> confirmPassword() async {
    if (_formKey.currentState!.validate()) {
      inProgress = true;
      setState(() {

      });
      final NetworkResponse response = await NetworkCaller()
          .postRequest(Urls.recoverResetPassword, body: {
        "email": widget.email,
        "OTP": widget.otp,
        "password": Confirmpassword.text
      });
      inProgress=false;
      setState(() {

      });
      if (response.isSuccess) {
        if (mounted) {
          ShowSnackMessage(context, 'PassWord changed ');
        }
        if (mounted) {
          Get.to(const loginScreen());
        }
      } else {
        if (mounted) {
          ShowSnackMessage(context, 'Password changed failed');
        }
      }
      inProgress=false;
      setState(() {

      });
    }
  }
}
