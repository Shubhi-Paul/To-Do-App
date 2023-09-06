import 'package:flutter/material.dart';
import 'package:to_do_list/constants/color.dart';
import 'package:to_do_list/view/widgets/task_card.dart';

import '../../model/todo.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();

  List<ToDo> _foundTasks = [];

  @override
  void initState() {
    _foundTasks = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        elevation: 0,
        backgroundColor: tdBGColor,
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CircleAvatar(
              backgroundColor: tdBlack,
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(FocusNode());},
        child: Container(
          color: tdBGColor,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search,
                          color: tdBlack,
                          size: 20,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          maxHeight: 30,
                          minWidth: 25,
                        ),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(color: tdGrey),
                      ))),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 20),
                child: const Text(
                  'All ToDos',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (ToDo todo in _foundTasks.reversed)
                      ToDoItems(
                        task: todo,
                        onToDoChanged: _handleToDoChange,
                        taskDelete: _deleteToDoItem,
                      )
                  ],
                ),
              ),
              Row(children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 5, left: 15, right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                        hintText: 'Add a new task', border: InputBorder.none),
                  ),
                )),
                Container(
                    margin: const EdgeInsets.only(bottom: 10, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _addToDoItems(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: tdBlue, minimumSize: const Size(55, 55)),
                      child: const Icon(Icons.add),
                    ))
              ])
            ],
          ),
        ),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((element) => element.TaskID == id);
    });
  }

  void _addToDoItems(String task) {
    if (task.isNotEmpty){
    setState(() {
      todoList.add(ToDo(
          TaskID: DateTime.now().millisecondsSinceEpoch.toString(),
          Task: task,
          isDone: false));
    });
    }
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> result = [];
    if (enteredKeyword.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((element) => element.Task!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTasks = result;
    });
  }
}
