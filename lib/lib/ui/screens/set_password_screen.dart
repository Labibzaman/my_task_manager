import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/ui/Controller/ScreenControllers/confirmPassword.dart';
import '../widgets/body_background.dart';
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
  TextEditingController Confirmpasswordcontroller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  ConfirmPasswordController confirmPasswordController =
      Get.find<ConfirmPasswordController>();
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
                      decoration:
                          const InputDecoration(hintText: 'New password'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: Confirmpasswordcontroller,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter same Password';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(hintText: 'confirm password'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<ConfirmPasswordController>(
                          builder: (password) {
                        return Visibility(
                          visible: password.inProgress == false,
                          replacement:
                              const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                confirmPasswordController.confirmPassword(
                                  widget.email,
                                  widget.otp,
                                  Confirmpasswordcontroller.text,
                                );
                              }
                            },
                            child: const Text('Confirm'),
                          ),
                        );
                      }),
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
                            Get.offAll(const loginScreen());
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
}
