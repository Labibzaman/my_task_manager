import 'package:get/get.dart';

import '../../../data/models/task_counModel.dart';
import '../../../data/network_caller.dart';
import '../../../data/network_response.dart';
import '../../../data/utility/urls.dart';

class TaskCountController extends GetxController{

  Task_summaryCountModel tasksummarycount = Task_summaryCountModel();
bool _taskSummaryCountprogress=false;

  bool get taskCountSummaryProgress =>_taskSummaryCountprogress;

  Future<void> getTASKcount() async {
    _taskSummaryCountprogress = true;
   update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskCount);
    if (response.isSuccess) {
      tasksummarycount = Task_summaryCountModel.fromJson(response.jsonResponse);
    }
    _taskSummaryCountprogress = false;
   update();
  }


}