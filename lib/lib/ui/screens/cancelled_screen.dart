import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/lib/ui/Controller/cancelled_controller.dart';
import '../widgets/profile_summary_Card.dart';
import '../widgets/taskitem_card.dart';

class cancell_screen extends StatefulWidget {
  const cancell_screen({super.key});

  @override
  State<cancell_screen> createState() => _cancell_screenState();
}

class _cancell_screenState extends State<cancell_screen> {
  CancelledController cancelledController = Get.find<CancelledController>();

  @override
  void initState() {
    super.initState();
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
                            },
                            showProgress: (inProgress) {},
                            refreshSummaryCard: () {},
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
