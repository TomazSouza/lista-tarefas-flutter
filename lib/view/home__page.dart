import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista_tarefas/layout_test.dart';
import 'package:lista_tarefas/models/todo.dart';
import 'package:lista_tarefas/repositories/todo_repository.dart';
import 'package:lista_tarefas/theme/colors_palette.dart';
import 'package:lista_tarefas/theme/theme_notifier.dart';
import 'package:lista_tarefas/widgets/footer_widget.dart';
import 'package:lista_tarefas/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage(this.themeNotifier, {Key? key}) : super(key: key);

  final ThemeNotifier themeNotifier;

  @override
  State<TodoListPage> createState() => _TodoListPageState(themeNotifier);
}

class _TodoListPageState extends State<TodoListPage> {
  final _hint_nova_tarefa = "Ex: Estudar Android";
  final _label_nova_tarefa = "Adicioner nova tarefa";
  final _tarefa_pendente = "Você possui 0 tarefas pendentes";
  final _limptar_tudo = "Limpar tudo";
  String? errorText;

  final TextEditingController _todoController = TextEditingController();
  final TodoRepository _todoRepository = TodoRepository();

  late ThemeNotifier? _themeNotifier;
  bool? _status;

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;

  _TodoListPageState(ThemeNotifier themeNotifier) {
    _themeNotifier = themeNotifier;
    _themeNotifier?.theme().then((value) {
      setState(() {
        _status = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _todoRepository.getTodoList().then((value) => setState(() {
          todos = value;
        }));
  }

  void onChange(bool value) {
    if (value) {
      _themeNotifier?.setDarkMode();
    } else {
      _themeNotifier?.setLightMode();
    }
    setState(() {
      _status = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: _status ?? false,
                    onChanged: onChange,
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              buildTextBox(context),
              const SizedBox(
                height: 16,
              ),
              buildListView(context),
              const SizedBox(
                height: 16,
              ),
              footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextBox(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _todoController,
            decoration: InputDecoration(
              hintText: _hint_nova_tarefa.toString(),
              labelText: _label_nova_tarefa.toString(),
              border: const OutlineInputBorder(),
              errorText: errorText,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsPalette.blue,
                  width: 2,
                )
              ),
              labelStyle: TextStyle(
                color: ColorsPalette.blue,
              )
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        ElevatedButton(
          child: const Icon(Icons.add),
          style: ElevatedButton.styleFrom(
            primary: ColorsPalette.blue,
            padding: const EdgeInsets.all(18),
          ),
          onPressed: () {
            var text = _todoController.text.trim();

            if (text.isEmpty) {
              setState(() {
                errorText = 'Título não pode ser vazio';
              });
              return;
            } else {
              errorText = null;
            }

            var todo = Todo(
              title: text,
              dateTime: DateTime.now(),
              length: todos.length + 1,
            );
            if (text != null || text.trim().isNotEmpty) {
              setState(() {
                todos.add(todo);
              });
              _todoController.clear();
              _todoRepository.saveTodoList(todos);
            }
          },
        ),
      ],
    );
  }

  Widget buildListView(BuildContext context) {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: [
          for (Todo todo in todos)
            TodoListItem(
              todo: todo,
              onDelete: onDelete,
              isNightMode: _status,
            )
        ],
      ),
    );
  }

  void onDelete(Todo? todo) {
    if (todo != null) {
      deletedTodo = todo;
      deletedTodoPos = todos.indexOf(todo);

      setState(() {
        todos.remove(todo);
      });

      _todoRepository.saveTodoList(todos);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Tarefa ${todo.title} removida com sucesso!",
            style: const TextStyle(
              color: Color(0xff060708),
            ),
          ),
          backgroundColor: Colors.white,
          action: SnackBarAction(
            label: "Desfazer",
            textColor: ColorsPalette.blue,
            onPressed: () {
              setState(() {
                todos.insert(deletedTodoPos!, deletedTodo!);
              });
              _todoRepository.saveTodoList(todos);
            },
          ),
        ),
      );
    }
  }

  Widget footer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(footerText()),
          ),
          const SizedBox(
            width: 8,
          ),
          ElevatedButton(
            child: Text(
              _limptar_tudo.toString(),
            ),
            style: ElevatedButton.styleFrom(
              primary: ColorsPalette.blue,
              padding: const EdgeInsets.all(14),
            ),
            onPressed: showDeleteTodoConfirmationDialog,
          ),
        ],
      ),
    );
  }

  void showDeleteTodoConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar tudo?"),
        content:
            const Text("Você tem certeza que deseja apagar todas as tarefas?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: ColorsPalette.blue,
            ),
            child: Text("Cancelar".toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            child: Text("Limpar tudo".toUpperCase()),
            onPressed: () {
              onDeleteAll();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void onDeleteAll() {
    setState(() {
      todos.clear();
    });
    _todoRepository.deleteAll();
  }

  String footerText() {
    if (todos.isEmpty || todos.length == 1) {
      return "Você possui ${todos.length} tarefa pendente";
    }
    return "Você possui ${todos.length} tarefas pendentes";
  }
}
