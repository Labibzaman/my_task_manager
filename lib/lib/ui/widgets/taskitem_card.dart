import 'package:flutter/material.dart';
import 'package:task_manager_app/lib/data/network_caller.dart';
import 'package:task_manager_app/lib/data/network_response.dart';
import 'package:task_manager_app/lib/data/utility/urls.dart';

import '../../data/models/task.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class Task_item_card extends StatefulWidget {
  Task_item_card({
    super.key,
    required this.task,
    required this.onStatusChange, required this.showProgress,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<Task_item_card> createState() => _Task_item_cardState();
}

class _Task_item_cardState extends State<Task_item_card> {


  Future<void> updateTaskstatus(String status) async {
    widget.showProgress(true);
    final  response = await NetworkCaller().getRequest(Urls.updateTaskStatus(widget.task.sId??'', status));
    if(response.isSuccess){
widget.onStatusChange();

    }
    widget.showProgress(false);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              widget.task.description ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.task.createdDate ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w200,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          showUpdateModal();
                        },
                        icon: const Icon(Icons.edit)),

                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateModal() {
    List<ListTile> items = TaskStatus.values
        .map(
          (e) => ListTile(
            onTap: () {
              updateTaskstatus(e.name);
              Navigator.pop(context);
            },
            title: Text('${e.name}'),
          ),
        )
        .toList();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
            actions: [
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),

                ],
              )
            ],
          );
        });
  }
}
