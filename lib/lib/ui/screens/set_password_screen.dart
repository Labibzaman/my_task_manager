import 'package:flutter/material.dart';

import '../widgets/body_background.dart';
import 'login_screen.dart';


class Set_password_screen extends StatefulWidget {
  const Set_password_screen({super.key});

  @override
  State<Set_password_screen> createState() => _Set_password_screenState();
}

class _Set_password_screenState extends State<Set_password_screen> {
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'New password'),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: 'confirm password'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return loginScreen();
                        }));
                      },
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
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
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
    );
  }
}
