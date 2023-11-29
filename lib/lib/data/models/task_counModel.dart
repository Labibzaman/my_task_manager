import 'package:task_manager_app/lib/data/models/task_count.dart';

class Task_summaryCountModel {
  String? status;
  List<Task_count>? taskCountList;

  Task_summaryCountModel({this.status, this.taskCountList});

  Task_summaryCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <Task_count>[];
      json['data'].forEach((v) {
        taskCountList!.add(Task_count.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    if (taskCountList != null) {
      data['data'] = taskCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
