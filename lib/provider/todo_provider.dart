import 'package:flutter/foundation.dart';
import '../model/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  final List<TODOModel> _todoList = [];

  List<TODOModel> get allTODOList => _todoList;

  void addToDoList(TODOModel todoModel){
    _todoList.add(todoModel);
    notifyListeners();
  }


  void todoStatusChange(TODOModel todoModel){
    final index = _todoList.indexOf(todoModel);
    _todoList[index].toggleCompleted();
    notifyListeners();
  }

  void removeToDoList(TODOModel todoModel){
    final index = _todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }
}