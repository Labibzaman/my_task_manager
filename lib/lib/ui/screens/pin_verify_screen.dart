import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/lib/data/network_caller.dart';
import 'package:task_manager_app/lib/data/network_response.dart';
import 'package:task_manager_app/lib/data/utility/urls.dart';
import 'package:task_manager_app/lib/ui/screens/set_password_screen.dart';

import '../widgets/body_background.dart';
import '../widgets/snack_message.dart';

class Pin_verify_screen extends StatefulWidget {
  Pin_verify_screen({super.key, required this.email});

  final String email;

  @override
  State<Pin_verify_screen> createState() => _Pin_verify_screenState();
}

class _Pin_verify_screenState extends State<Pin_verify_screen> {
  TextEditingController pinController = TextEditingController();
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
                    Text('Pin Verification',
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
                    PinCodeTextField(
                      controller: pinController,
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter Pin';
                        }
                        return null;
                      },
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                        activeColor: Colors.green,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {},
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: verifyOTP,
                        child: Visibility(
                            visible: inProgress == false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: const Text('Verify')),
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

  Future<void> verifyOTP() async {
    if (_formKey.currentState!.validate()) {
      inProgress = true;
      if (mounted) {
        setState(() {});
      }
      if (mounted) {
        ShowSnackMessage(context, 'Please wait for confirmation');
      }
      final NetworkResponse response = await NetworkCaller()
          .getRequest(Urls.verifyOTP(widget.email, pinController.text));

      if (response.isSuccess && response.jsonResponse != null) {
        Map<dynamic, dynamic> pinVerify = response.jsonResponse;
        if (pinVerify['status'] == 'success') {
          if (mounted) {
            Get.offAll(Set_password_screen(
              email: widget.email,
              otp: pinController.text,
            ));
            inProgress = false;
            setState(() {});
          }
        } else {
          if (mounted) {
            ShowSnackMessage(context, 'Invalid Pin verification failed');
          }
        }
        inProgress = false;
        setState(() {});
      }
    }
  }
}
