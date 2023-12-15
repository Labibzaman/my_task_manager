import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/ui/Controller/ScreenControllers/taskCountController.dart';
import 'package:task_manager_app/lib/ui/Controller/completeTaskController.dart';
import '../../data/models/task_counModel.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/taskitem_card.dart';

class Completed_screen extends StatefulWidget {
  const Completed_screen({super.key});

  @override
  State<Completed_screen> createState() => _Completed_screenState();
}

class _Completed_screenState extends State<Completed_screen> {
  bool taskSummaryCountprogress = false;

  Task_Model taskListModel = Task_Model();
  Task_summaryCountModel tasksummarycount = Task_summaryCountModel();

  Future<void> getTASKcount() async {
    taskSummaryCountprogress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getTaskCount);
    if (response.isSuccess) {
      tasksummarycount = Task_summaryCountModel.fromJson(response.jsonResponse);
    }
    taskSummaryCountprogress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    Get.find<CompleteTaskController>().getNewTaskList();
    getTASKcount();
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
                          getTASKcount();
                          completeTask.getNewTaskList();
                        },
                        showProgress: (inProgress) {},
                        refreshSummaryCard: () {
                          getTASKcount();
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
