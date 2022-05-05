import 'dart:convert';

import 'package:lista_tarefas/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String key_todo_list = "todo_list";

class TodoRepository {
  SharedPreferences? _sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    final json = _sharedPreferences?.getString(key_todo_list) ?? '[]';
    final List decoded = jsonDecode(json) as List;
    print(decoded);
    return decoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> list) {
    final jsonString = jsonEncode(list);
    print(jsonString);
    _sharedPreferences?.setString(key_todo_list, jsonString);
  }

  void deleteAll() {
    _sharedPreferences?.remove(key_todo_list);
  }
}
