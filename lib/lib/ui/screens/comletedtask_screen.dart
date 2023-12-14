import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/ui/Controller/completeTaskController.dart';

import '../../data/models/task_counModel.dart';
import '../../data/models/task_count.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/showsummary_card.dart';
import '../widgets/taskitem_card.dart';

class Completed_screen extends StatefulWidget {
  const Completed_screen({super.key});

  @override
  State<Completed_screen> createState() => _Completed_screenState();
}

class _Completed_screenState extends State<Completed_screen> {
  CompleteTaskController completeTaskController =
      Get.find<CompleteTaskController>();

  @override
  void initState() {
    super.initState();
    Get.find<CompleteTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary_Card(),
            Expanded(child:
                GetBuilder<CompleteTaskController>(builder: (completeTask) {
              return Visibility(
                visible: completeTask.newTaskListProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () => completeTask.getNewTaskList(),
                  child: ListView.builder(
                    itemCount: completeTask.taskListModel.taskList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Task_item_card(
                        task: completeTask.taskListModel.taskList![index],
                        onStatusChange: () {
                          completeTask.getNewTaskList();
                        },
                        showProgress: (inProgress) {},
                        refreshSummaryCard: () {
                          completeTask.getNewTaskList();
                        },
                      );
                    },
                  ),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}
