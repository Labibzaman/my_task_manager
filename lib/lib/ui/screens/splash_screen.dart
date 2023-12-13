import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/ui/Controller/authController.dart';
import '../widgets/body_background.dart';
import 'login_screen.dart';
import 'main_bottm_nav_screen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    super.initState();
    gotoLogin();
  }

  void gotoLogin() async {
final bool isLoggedin = await Get.find<AuthController>().CheckAuth();
    Future.delayed(const Duration(seconds: 2)).then((value) {

      Get.offAll(isLoggedin
          ? const MainBottomNavScreen() : const loginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
      child: Center(
        child: SvgPicture.asset(
          'assets/images/logo.svg',
          width: 120,
        ),
      ),
    ));
  }
}
