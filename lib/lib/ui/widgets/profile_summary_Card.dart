import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.onenabled == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()));
        }
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        fullname,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        AuthController.user?.email ?? '',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      ),
      tileColor: Colors.green,
      trailing: IconButton(
        onPressed: () async {
          await AuthController.clearAuthData();
          if (mounted) {
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
             return const loginScreen();
           }), (route) => false);
          }
        },
        icon: Icon(Icons.login_outlined),
      ),
    );
  }

  String get fullname {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName}';
  }
}
