import 'package:flutter/material.dart';
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
                    Text(
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
                      decoration: InputDecoration(hintText: 'New password'),
                    ),
                    SizedBox(
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
                      decoration: InputDecoration(hintText: 'confirm password'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: confirmPassword,
                        child: Text('Confirm'),
                      ),
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
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
                          child: Text(
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
      final NetworkResponse response = await NetworkCaller()
          .postRequest(Urls.recoverResetPassword, body: {
        "email": widget.email,
        "OTP": widget.otp,
        "password": Confirmpassword.text
      });
      if (response.isSuccess) {
        if (mounted) {
          ShowSnackMessage(context, 'PassWord changed ');
        }
        if (mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const loginScreen();
          }));
        }
      } else {
        if (mounted) {
          ShowSnackMessage(context, 'Password changed failed');
        }
      }
    }
  }
}
