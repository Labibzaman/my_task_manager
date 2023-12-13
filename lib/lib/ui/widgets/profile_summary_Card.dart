import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/lib/ui/Controller/authController.dart';
import 'package:task_manager_app/lib/ui/screens/login_screen.dart';
import '../screens/edit_profile_screen.dart';

class ProfileSummary_Card extends StatefulWidget {
  const ProfileSummary_Card({
    super.key,
    this.onenabled = true,
  });

  final bool onenabled;

  @override
  State<ProfileSummary_Card> createState() => _ProfileSummary_CardState();
}

class _ProfileSummary_CardState extends State<ProfileSummary_Card> {
  AuthController authcontroller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {

      String base64String = authController.user?.photo ?? '';

      if (base64String.startsWith('data:image')) {
        // Remove data URI prefix if present
        base64String =
            base64String.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
      }

      Uint8List imageBytes = Base64Decoder().convert(base64String);

      return ListTile(
        onTap: () {
          if (widget.onenabled == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileScreen()));
          }
        },
        leading: CircleAvatar(
          child: authController.user?.photo == null
              ? const Icon(Icons.person)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: Image.memory(
                    imageBytes,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        title: Text(
          fullname(authController),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          authController.user?.email ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        tileColor: Colors.green,
        trailing: IconButton(
          onPressed: () async {
            await AuthController.clearAuthData();
            if (mounted) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const loginScreen();
              }), (route) => false);
            }
          },
          icon: Icon(Icons.login_outlined),
        ),
      );
    });
  }

  String fullname(AuthController authController) {
    return '${authController.user?.firstName ?? ''} ${authController.user?.lastName}';
  }
}
