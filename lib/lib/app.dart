import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager_app/lib/ui/Controller/New_task_controller.dart';
import 'package:task_manager_app/lib/ui/Controller/ScreenControllers/confirmPassword.dart';
import 'package:task_manager_app/lib/ui/Controller/ScreenControllers/forgetController.dart';
import 'package:task_manager_app/lib/ui/Controller/ScreenControllers/signUpcontroller.dart';
import 'package:task_manager_app/lib/ui/Controller/ScreenControllers/taskCountController.dart';
import 'package:task_manager_app/lib/ui/Controller/authController.dart';
import 'package:task_manager_app/lib/ui/Controller/cancelled_controller.dart';
import 'package:task_manager_app/lib/ui/Controller/completeTaskController.dart';
import 'package:task_manager_app/lib/ui/Controller/login_controller.dart';
import 'package:task_manager_app/lib/ui/Controller/progressTaskController.dart';
import 'package:task_manager_app/lib/ui/screens/splash_screen.dart';

class TasKmanagerApp extends StatefulWidget {
  static GlobalKey<NavigatorState> NavigationKey = GlobalKey<NavigatorState>();

  const TasKmanagerApp({super.key});

  @override
  State<TasKmanagerApp> createState() => _TasKmanagerAppState();
}

class _TasKmanagerAppState extends State<TasKmanagerApp> {
  static GlobalKey<NavigatorState> NavigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationKey,
      initialBinding: ControllerBindings(),
      home: const splashScreen(),
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
          ),
          primaryColor: CupertinoColors.activeGreen,
          primarySwatch: Colors.green,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ))),
    );
  }
}

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(LoginController());
    Get.put(NewTask_Controller());
    Get.put(ProgressTaskController());
    Get.put(CancelledController());
    Get.put(CompleteTaskController());
    Get.put(ForgetController());
    Get.put(ConfirmPasswordController());
    Get.put(SignUpController());
    Get.put(TaskCountController());
  }
}
