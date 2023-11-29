import 'package:flutter/material.dart';

import '../widgets/body_background.dart';
import '../widgets/profile_summary_Card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      'Add New Task',
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
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.arrow_circle_right_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }



  Container photoPicker() {
    return Container(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )
                                ),

                                alignment: Alignment.center,
                                child: Text(
                                  'Photo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white
                                  ),
                                ),
                              )),
                          Expanded(flex: 3, child: Container(
                            alignment: Alignment.center,
                            child: TextFormField(),
                          ),),
                        ],
                      ),
                    );
  }
}
