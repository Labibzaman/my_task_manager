import 'package:flutter/material.dart';
import 'package:task_manager_app/lib/ui/screens/pin_verify_screen.dart';

import '../widgets/body_background.dart';


class Forget_screen extends StatefulWidget {
  const Forget_screen({super.key});

  @override
  State<Forget_screen> createState() => _Forget_screenState();
}

class _Forget_screenState extends State<Forget_screen> {
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
                  Text('Your Email Address',
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
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Pin_verify_screen();
                        }));
                      },
                      child: Icon(Icons.arrow_circle_right_outlined),
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
