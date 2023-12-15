import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager_app/lib/ui/Controller/progressTaskController.dart';
import '../../data/models/task_counModel.dart';
import '../../data/models/task_count.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/showsummary_card.dart';
import '../widgets/taskitem_card.dart';

class InProgress_Screen extends StatefulWidget {
  const InProgress_Screen({super.key});

  @override
  State<InProgress_Screen> createState() => _InProgress_ScreenState();
}

class _InProgress_ScreenState extends State<InProgress_Screen> {

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
    Get.find<ProgressTaskController>().getProgressTaskList();
    getTASKcount();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary_Card(),
            Expanded(
                child: GetBuilder<ProgressTaskController>(
                  builder: (progressTask) {
                    return Visibility(
                      visible: progressTask.newTaskListProgress == false,
                      replacement: const Center(child: CircularProgressIndicator()),
                      child: RefreshIndicator(
                        onRefresh:()=> progressTask.getProgressTaskList(),
                        child: ListView.builder(
                          itemCount: progressTask.TasklistModel.taskList?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Task_item_card(
                              task: progressTask.TasklistModel.taskList![index],
                              onStatusChange: () {
                                getTASKcount();
                                progressTask.getProgressTaskList();
                              },
                              showProgress: (inProgress) {}, refreshSummaryCard: () {
                              getTASKcount();
                              progressTask.getProgressTaskList();
                            },
                            );
                          },
                        ),
                      ),
                    );
                  }
                )),
          ],
        ),
      ),
    );
  }
}

