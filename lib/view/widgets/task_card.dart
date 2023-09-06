import 'package:flutter/material.dart';
import 'package:to_do_list/constants/color.dart';

import '../../model/todo.dart';

class ToDoItems extends StatelessWidget {
  final onToDoChanged;
  final taskDelete;
  final ToDo task;
  const ToDoItems(
      {required this.task,
      required this.onToDoChanged,
      required this.taskDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          onTap: () {
            onToDoChanged(task);
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: task.isDone
              ? Icon(
                  Icons.check_box,
                  color: tdBlue,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: tdBlue,
                ),
          title: Text(
            task.Task!,
            style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Container(
              decoration: BoxDecoration(
                  color: tdRed, borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(5),
              child: IconButton(
                icon :
                Icon(Icons.delete,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                taskDelete(task.TaskID);
              },)
              ),
        ));
  }
}
