import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/lib/ui/screens/set_password_screen.dart';

import '../widgets/body_background.dart';

class Pin_verify_screen extends StatefulWidget {
  const Pin_verify_screen({super.key});

  @override
  State<Pin_verify_screen> createState() => _Pin_verify_screenState();
}

class _Pin_verify_screenState extends State<Pin_verify_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pin Verification',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
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
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      return true;
                    },
                    appContext: context,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Set_password_screen();
                        }));
                      },
                      child: Text('Verify'),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  SizedBox(
                    height: 10,
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
                          Navigator.pop(context);
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
    );
  }
}
