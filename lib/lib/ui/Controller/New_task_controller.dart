import 'package:get/get.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller.dart';
import '../../data/network_response.dart';
import '../../data/utility/urls.dart';

class NewTask_Controller extends GetxController{

bool _newTaskListInProgress = false;

Task_Model _taskListModel = Task_Model();

bool get newTaskListinProgress => _newTaskListInProgress;

Task_Model get taskListModel => _taskListModel;

  Future<bool> getNewTaskList() async {
    bool isSuccess = false;

    _newTaskListInProgress = true;
   update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getNewTaskList);
    _newTaskListInProgress = false;

    if (response.isSuccess) {
      _taskListModel = Task_Model.fromJson(response.jsonResponse);
      return isSuccess = true;
    }
    update();
    return isSuccess;

  }

}