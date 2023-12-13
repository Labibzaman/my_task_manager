import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/lib/data/models/task_count.dart';
import 'package:task_manager_app/lib/data/network_caller.dart';
import 'package:task_manager_app/lib/data/network_response.dart';
import 'package:task_manager_app/lib/data/utility/urls.dart';
import 'package:task_manager_app/lib/ui/Controller/New_task_controller.dart';
import '../../data/models/task_counModel.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/showsummary_card.dart';
import '../widgets/taskitem_card.dart';
import 'add_new_task_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool taskSummaryCountprogress = false;
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
    Get.find<NewTask_Controller>().getNewTaskList();
    getTASKcount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return AddNewTaskScreen(
              onTaskAdded: () {
                getTASKcount();
                Get.find<NewTask_Controller>().getNewTaskList();
              },
            );
          }));
          if (response != null && response == true) {
            getTASKcount();
            Get.find<NewTask_Controller>().getNewTaskList();
            getTASKcount();
          }
        },
        child: const Icon(CupertinoIcons.plus_circle),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary_Card(),
            Visibility(
              visible: taskSummaryCountprogress == false,
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tasksummarycount.taskCountList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Task_count taskcountDetails =
                        tasksummarycount.taskCountList![index];
                    return FittedBox(
                      child: summaryCard(
                        title: taskcountDetails.sId ?? '',
                        num: taskcountDetails.sum.toString(),
                        onStatusChange: () {
                          getTASKcount();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(child:
                GetBuilder<NewTask_Controller>(builder: (newTaskController) {
              return Visibility(
                visible: newTaskController.newTaskListinProgress == false,
                replacement: const Center(child: CircularProgressIndicator()),
                child: RefreshIndicator(
                  onRefresh: () => newTaskController.getNewTaskList(),
                  child: ListView.builder(
                    itemCount:
                        newTaskController.taskListModel.taskList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Task_item_card(
                        task: newTaskController.taskListModel.taskList![index],
                        onStatusChange: () {
                          getTASKcount();
                          newTaskController.getNewTaskList();
                        },
                        showProgress: (inProgress) {},
                        refreshSummaryCard: () {
                          getTASKcount();
                          newTaskController.getNewTaskList();
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
