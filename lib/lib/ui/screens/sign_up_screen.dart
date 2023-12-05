import 'package:flutter/material.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/body_background.dart';
import '../widgets/snack_message.dart';
import 'login_screen.dart';

class Sign_up_screen extends StatefulWidget {
  const Sign_up_screen({super.key});

  @override
  State<Sign_up_screen> createState() => _Sign_up_screenState();
}

class _Sign_up_screenState extends State<Sign_up_screen> {
  final TextEditingController _emailTecontroller = TextEditingController();
  final TextEditingController _firstNameTecontroller = TextEditingController();
  final TextEditingController _lastNameTecontroller = TextEditingController();
  final TextEditingController _MobileTecontroller = TextEditingController();
  final TextEditingController _passwordTEcontroller = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _signupInProgress = false;

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
                    Text('Join With Us',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _emailTecontroller,
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter email';
                        }if(!isValidEmail(value!)){
                          return  'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _firstNameTecontroller,
                      decoration: const InputDecoration(hintText: 'First Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter FirstName';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _lastNameTecontroller,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter lastName';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _MobileTecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Mobile'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Mobile';
                        }if(!isValidPhoneNumber(value!)){
                          return 'Enter a valid Mobile number';
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
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'Enter password';
                        }
                        if (value!.length < 6) {
                          return 'Your password should be more than 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signupInProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: Visibility(
                          visible: _signupInProgress==false,
                          replacement: const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: signUp,
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
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
                            " Have an Account ?",
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
                              return const loginScreen();
                            }));
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

  Future<void> signUp () async {

    if (_formkey.currentState!.validate()) {
      _signupInProgress = true;
      if(mounted){
        setState(() {

        });
      }
      final NetworkResponse response =
      await NetworkCaller()
          .postRequest(Urls.registration,body: {
        "email":_emailTecontroller.text.trim(),
        "firstName":_firstNameTecontroller.text.trim(),
        "lastName":_lastNameTecontroller.text.trim(),
        "mobile":_MobileTecontroller.text.trim(),
        "password":_passwordTEcontroller.text.trim(),

      });
      _signupInProgress = false;
      if(mounted){
        setState(() {

        });
      }
      if (response.statusCode == 200) {
        clearTextfiled();
        if (mounted) {
          ShowSnackMessage(
            context,
            'Your Account has been created, login ',
            false,
          );
        }
      } else {
        if (mounted) {
          ShowSnackMessage(
            context,
            'Your Account has not created, failed ',
            true,
          );
        }
      }
    }
  }

  void clearTextfiled() {
    _emailTecontroller.clear();
    _firstNameTecontroller.clear();
    _lastNameTecontroller.clear();
    _MobileTecontroller.clear();
    _passwordTEcontroller.clear();
  }

  @override
  void dispose() {
    _emailTecontroller.dispose();
    _firstNameTecontroller.dispose();
    _lastNameTecontroller.dispose();
    _MobileTecontroller.dispose();
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

  bool isValidPhoneNumber(String phoneNumber) {
    // Define a regular expression for a valid phone number
    final RegExp phoneRegex = RegExp(
      r'^[0-9]{10}$',
    );
    return phoneRegex.hasMatch(phoneNumber);
  }

}
