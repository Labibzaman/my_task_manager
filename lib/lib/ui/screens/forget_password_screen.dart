import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/data/network_caller.dart';
import 'package:task_manager_app/lib/data/network_response.dart';
import 'package:task_manager_app/lib/data/utility/urls.dart';
import 'package:task_manager_app/lib/ui/Controller/ScreenControllers/forgetController.dart';
import 'package:task_manager_app/lib/ui/screens/pin_verify_screen.dart';

import '../widgets/body_background.dart';
import '../widgets/snack_message.dart';

class Forget_screen extends StatefulWidget {
  const Forget_screen({super.key});

  @override
  State<Forget_screen> createState() => _Forget_screenState();
}

class _Forget_screenState extends State<Forget_screen> {
  TextEditingController emailControler = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();

  final ForgetController forgetController = Get.find<ForgetController>();
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
                    Text('Your Email Address',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'A 6 digit OTP will be sent to your email',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: emailControler,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: getVerifyemail,
                        child: GetBuilder<ForgetController>(builder: (forget) {
                          return Visibility(
                            visible: forget.inProgress == false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: Text('Get OTP'),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    const SizedBox(
                      height: 10,
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
                            Navigator.pop(context);
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

  Future<void> getVerifyemail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final response = await forgetController.getVerifyemail(emailControler.text);
    if (response) {
      Get.to(Pin_verify_screen(email: emailControler.text));
    } else {
      if (mounted) {
        ShowSnackMessage(context, forgetController.message);
      }
    }
  }
}

// Future<void> getVerifyemail() async {
//   if(_formKey.currentState!.validate()){
//
//     if (mounted) {
//       ShowSnackMessage(context, 'Please wait for confirmation');
//     }
//     inProgress = true;
//     setState(() {});
//     final NetworkResponse response =
//     await NetworkCaller().getRequest(Urls.verifyEmail(emailControler.text));
//     if (response.isSuccess) {
//       Get.to(Pin_verify_screen(email:emailControler.text));
//     } else {
//       if (mounted) {
//         ShowSnackMessage(context, 'Enter correct email');
//       }
//     }
//     inProgress = false;
//     setState(() {});
//   }}
