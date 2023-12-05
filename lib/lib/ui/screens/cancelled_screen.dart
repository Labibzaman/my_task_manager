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

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            const ProfileSummary_Card(),

            Expanded(
                child: Visibility(
                  visible: newTaskListInProgress == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: getNewTaskList,
                    child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Task_item_card(
                          task: taskListModel.taskList![index],
                          onStatusChange: () {

                            getNewTaskList();
                          },
                          showProgress: (inProgress) {
                            newTaskListInProgress = inProgress;
                            if (mounted) {
                              setState(() {});
                            }
                          }, refreshSummaryCard: () {  },
                        );
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}


