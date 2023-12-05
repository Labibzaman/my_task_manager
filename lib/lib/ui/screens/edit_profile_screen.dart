import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/lib/data/models/userModels.dart';
import 'package:task_manager_app/lib/data/network_caller.dart';
import 'package:task_manager_app/lib/data/utility/urls.dart';
import 'package:task_manager_app/lib/ui/Controller/authController.dart';
import '../../data/network_response.dart';
import '../widgets/body_background.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/snack_message.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController photoTeController = TextEditingController();
  TextEditingController emailTeController = TextEditingController();
  TextEditingController FirstNameTeController = TextEditingController();
  TextEditingController LastNameTeController = TextEditingController();
  TextEditingController MobileTeController = TextEditingController();
  TextEditingController PasswordTeController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool inProgress = false;
  XFile? photo;


  @override
  void initState() {
    super.initState();
    emailTeController.text = AuthController.user?.email ?? '';
    FirstNameTeController.text = AuthController.user?.firstName ?? '';
    LastNameTeController.text = AuthController.user?.lastName ?? '';
    MobileTeController.text = AuthController.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            ProfileSummary_Card(
              onenabled: false,
            ),
            Expanded(
              child: BodyBackground(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 28,
                      ),
                      Text(
                        'Update Profile',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: photoPicker(),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      TextFormField(
                        controller: emailTeController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Enter email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: FirstNameTeController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Enter First Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: LastNameTeController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Enter Last Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: MobileTeController,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Enter Mobile';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: PasswordTeController,
                        decoration: const InputDecoration(
                          hintText: 'Password (optional)',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            updateProfile();
                          },
                          child: Visibility(
                              visible: inProgress == false,
                              replacement: const Center(
                                  child: CircularProgressIndicator()),
                              child: const Icon(
                                  Icons.arrow_circle_right_outlined)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> updateProfile() async {
    String?photoinBase64;
 
    Map<String, dynamic> inputData = {

      "email": emailTeController.text.trim(),
      "firstName": FirstNameTeController.text.trim(),
      "lastName": LastNameTeController.text.trim(),
      "mobile": MobileTeController.text.trim(),
    };
    if (PasswordTeController.text.isNotEmpty) {
      inputData['password'] = PasswordTeController.text;
    }
    if(photo !=null){
      List<int> imageBytes = await photo!.readAsBytes();
       photoinBase64 = base64Encode(imageBytes);
      inputData['photo'] = photoinBase64;
    }

    if (_formKey.currentState!.validate()) {
      inProgress = true;
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response = await NetworkCaller().postRequest(
        Urls.updateProfile,
        body: inputData,
      );
      if (response.isSuccess) {
        AuthController.UpdateUserInformation(UserModel(
          email: emailTeController.text.trim(),
          firstName: FirstNameTeController.text.trim(),
          lastName: LastNameTeController.text.trim(),
          mobile: MobileTeController.text.trim(),
          photo:photoinBase64 ?? AuthController.user?.photo
        ));
        if (mounted) {
          ShowSnackMessage(context, 'Success');
        }
      }
    } else {
      if (mounted) {
        ShowSnackMessage(context, 'Failed', true);
      }
    }
    inProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Container photoPicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(8),
                    )),
                alignment: Alignment.center,
                child: const Text(
                  'Photo',
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.white),
                ),
              )),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () async {
                final XFile? image = await ImagePicker()
                    .pickImage(source: ImageSource.camera, imageQuality: 50);
                if (image != null) {
                  photo = image;
                  if (mounted) {
                    setState(() {});
                  }
                }
              },
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                    visible: photo == null,
                    replacement: Text(photo?.name ?? ''),
                    child: const Text('   Select a photo')),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
