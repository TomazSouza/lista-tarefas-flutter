import 'package:flutter/material.dart';

import '../models/todo.dart';

class FotterWidget extends StatelessWidget {
  const FotterWidget({Key? key, required this.todos, required this.onDeleteAll})
      : super(key: key);

  final List<Todo>? todos;
  final Function() onDeleteAll;

  final _limptar_tudo = "Limpar tudo";

  @override
  Widget build(BuildContext context) {
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
              primary: const Color(0xff00D7F3),
              padding: const EdgeInsets.all(14),
            ),
            onPressed: () {
              onDeleteAll();
            },
          ),
        ],
      ),
    );
  }

  String footerText() {
    if (todos?.length == 0 || todos?.length == 1) {
      return "Você possui ${todos?.length} tarefa pendente";
    }
    return "Você possui ${todos?.length} tarefas pendentes";
  }
}
