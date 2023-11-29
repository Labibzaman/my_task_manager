import 'package:flutter/material.dart';
import '../../data/models/task_counModel.dart';
import '../../data/models/task_count.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/showsummary_card.dart';
import '../widgets/taskitem_card.dart';

class cancell_screen extends StatefulWidget {
  const cancell_screen({super.key});

  @override
  State<cancell_screen> createState() => _cancell_screenState();
}

class _cancell_screenState extends State<cancell_screen> {

  bool newTaskListInProgress = false;
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

  Future<void> getNewTaskList() async {
    newTaskListInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCancelledTaskList);
    if (response.isSuccess) {
      taskListModel = Task_Model.fromJson(response.jsonResponse);
    }
    newTaskListInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getNewTaskList();
    getTASKcount();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
                child: Visibility(
                  visible: newTaskListInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Task_item_card(
                        task: taskListModel.taskList![index],
                        onStatusChange: () {
                          getTASKcount();
                          getNewTaskList();
                        },
                        showProgress: (inProgress) {
                          newTaskListInProgress = inProgress;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}


