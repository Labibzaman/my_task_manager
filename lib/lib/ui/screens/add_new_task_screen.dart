import 'package:flutter/material.dart';
import 'package:task_manager_app/lib/data/network_caller.dart';
import 'package:task_manager_app/lib/data/network_response.dart';
import 'package:task_manager_app/lib/data/utility/urls.dart';
import 'package:task_manager_app/lib/ui/widgets/snack_message.dart';

import '../widgets/body_background.dart';
import '../widgets/profile_summary_Card.dart';

class AddNewTaskScreen extends StatefulWidget {
   AddNewTaskScreen({super.key, required this.onTaskAdded});
  final VoidCallback onTaskAdded;

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTeController = TextEditingController();
  final TextEditingController _descripTeController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const ProfileSummary_Card(),
              Expanded(
                child: BodyBackground(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 28,
                        ),
                        Text(
                          'Add New Task',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        TextFormField(
                          controller: _titleTeController,
                          decoration: const InputDecoration(hintText: 'Title'),
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return 'Enter Title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        TextFormField(
                          controller: _descripTeController,
                          maxLines: 8,
                          decoration:
                              const InputDecoration(hintText: 'Description'),
                          validator: (String? value) {
                            if (value!.trim().isEmpty) {
                              return 'Enter Description';
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
                            visible: isAdded == false,
                            replacement: const Center(
                                child: CircularProgressIndicator()),
                            child: ElevatedButton(
                              onPressed: addnewTask,
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> addnewTask() async {
    if (_formkey.currentState!.validate()) {
      isAdded = true;
      if (mounted) {
        setState(() {});
      }
      NetworkResponse response =
          await NetworkCaller().postRequest(Urls.addNewTask, body: {
        "title": _titleTeController.text,
        "description": _descripTeController.text,
        "status": "New",
      });
      isAdded = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        widget.onTaskAdded();
        clearTextfiled();

        if (mounted) {
          ShowSnackMessage(context, 'Task Added successfully');
        }
      }else{
        if (mounted) {
          ShowSnackMessage(context, 'Something went wrong',true);
        }
      }
    }
  }

  void clearTextfiled() {
    _descripTeController.clear();
    _titleTeController.clear();
  }

  @override
  void dispose() {
    _titleTeController.dispose();
    _descripTeController.clear();
    super.dispose();
  }
}
