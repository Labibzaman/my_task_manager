import 'package:get/get.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';

class ProgressTaskController extends GetxController{
  bool _newTaskListInProgress = false;

  Task_Model _taskListModel = Task_Model();

  bool get newTaskListProgress => _newTaskListInProgress;
  Task_Model get TasklistModel => _taskListModel;


  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _newTaskListInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getProgressTaskList);
    _newTaskListInProgress = false;
    if (response.isSuccess) {
      _taskListModel = Task_Model.fromJson(response.jsonResponse);
      return isSuccess = true;
    }
    update();
    return isSuccess;
  }
}