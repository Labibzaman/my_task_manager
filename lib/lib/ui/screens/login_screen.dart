import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/data/models/userModels.dart';
import 'package:task_manager_app/lib/ui/Controller/authController.dart';
import 'package:task_manager_app/lib/ui/Controller/login_controller.dart';
import 'package:task_manager_app/lib/ui/screens/sign_up_screen.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/body_background.dart';
import '../widgets/snack_message.dart';
import 'forget_password_screen.dart';
import 'main_bottm_nav_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController _emailTEcontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
final LoginController _loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Get Started With',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailTEcontroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter email';
                        }if(!isValidEmail(value)){
                          return  'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordTEcontroller,
                      decoration: const InputDecoration(hintText: 'Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<LoginController>(
                        builder: (loginController) {
                          return Visibility(
                            visible: loginController.LoginProgress == false,
                            replacement:
                                const Center(child: CircularProgressIndicator()),
                            child: ElevatedButton(
                              onPressed: login,
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          );
                        }
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Forget_screen();
                          }));
                        },
                        child: const Text(
                          'Forget Password ?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45,
                          ),
                        ),
                      ),
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
                            "Don't Have an Account ?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const Sign_up_screen();
                            }));
                          },
                          child: const Text(
                            'Sign Up',
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

  Future<void> login() async {

    if(!_formkey.currentState!.validate()){
      return;
    }
      final response = await _loginController.login(
          _emailTEcontroller.text.trim(), _passwordTEcontroller.text.trim());
      if (response) {
        Get.offAll(const MainBottomNavScreen());
      } else {
        if (mounted) {
          ShowSnackMessage(context, _loginController.message);
        }
      }
    }


  @override
  void dispose() {
    _emailTEcontroller.dispose();
    _passwordTEcontroller.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    // Define a regular expression for a valid email address
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    );
    return emailRegex.hasMatch(email);
  }
}
