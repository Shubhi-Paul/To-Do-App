class ToDo {
  String? TaskID;
  String? Task;
  bool isDone;

  ToDo({
    required this.TaskID,
    required this.Task,
    required this.isDone
  });

  static List<ToDo> todoList() {
    return [
      ToDo(TaskID: '01', Task: 'Lets get started', isDone: true),
      ToDo(TaskID: '02', Task: 'Add new task as and when you liken ',isDone: false), 
    ];
  }
}
