import 'package:flutter/material.dart';
import 'package:task_manager_app/lib/ui/widgets/taskitem_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String addNewTask = '$_baseUrl/createTask';
  static  String getNewTaskList = '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static  String getProgressTaskList = '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static  String getCompletedTaskList = '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static  String getCancelledTaskList = '$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}';
  static const String getTaskCount = '$_baseUrl/taskStatusCount';
  static const String taskCancelled = '$_baseUrl/listTaskByStatus/Cancelled';
  static const String updateProfile = '$_baseUrl/profileUpdate';
  static const String recoverResetPassword = '$_baseUrl/RecoverResetPass';


  static String updateTaskStatus(String taskID,String taskstatus) {
   return '$_baseUrl/updateTaskStatus/$taskID/$taskstatus';
  }

  static String deleteTASK(dynamic taskid) {
    return '$_baseUrl/deleteTask/$taskid';
  }

  static String verifyEmail(String emailID) {
    return '$_baseUrl/RecoverVerifyEmail/$emailID';
  }
  static String verifyOTP(String emailID,String otp) {
    return '$_baseUrl/RecoverVerifyOTP/$emailID/$otp';
  }
}