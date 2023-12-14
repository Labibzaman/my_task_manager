import 'package:get/get.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';

class CompleteTaskController extends GetxController {
  bool _newTaskListInProgress = false;

  bool get newTaskListProgress => _newTaskListInProgress;

  Task_Model _taskListModel = Task_Model();

  Task_Model get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _newTaskListInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCompletedTaskList);
    if (response.isSuccess) {
      _taskListModel = Task_Model.fromJson(response.jsonResponse);
      _newTaskListInProgress = false;
      return isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
