import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/ui/Controller/cancelled_controller.dart';
import '../../data/models/task_counModel.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/taskitem_card.dart';

class cancell_screen extends StatefulWidget {
  const cancell_screen({super.key});

  @override
  State<cancell_screen> createState() => _cancell_screenState();
}

class _cancell_screenState extends State<cancell_screen> {
  CancelledController cancelledController = Get.find<CancelledController>();



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
    getTASKcount();
    Get.find<CancelledController>().getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary_Card(),
            Expanded(
              child: GetBuilder<CancelledController>(
                builder: (cancelled) {
                  return Visibility(
                    visible: cancelled.cancelledTaskProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: () => cancelled.getCancelledTaskList(),
                      child: ListView.builder(
                        itemCount: cancelled.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Task_item_card(
                            task: cancelled.taskListModel.taskList![index],
                            onStatusChange: () {
                              cancelled.getCancelledTaskList();
                              getTASKcount();
                            },
                            showProgress: (inProgress) {},
                            refreshSummaryCard: () {
                              getTASKcount();
                              cancelledController.getCancelledTaskList();
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
