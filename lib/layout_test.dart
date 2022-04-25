import 'package:flutter/material.dart';

class LayoutTest {


  final TextEditingController _emailController = TextEditingController();

  Widget textField() {
    return TextField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Preço',
        hintText: 'example@exemplo.com',
        errorText: null,
        prefixText: 'R\$',
        suffixText: 'cm',
        labelStyle: TextStyle(
          fontSize: 40.0,
        ),
      ),
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: Colors.purple,
      ),
    );
  }

  Widget body() {
    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.vertical,
      children: [
        Container(
          width: 160.0,
          height: 300.0,
          color: Colors.red,
        ),
        Container(
          width: 160.0,
          height: 300.0,
          color: Colors.blue,
        ),
        Container(
          width: 160.0,
          height: 300.0,
          color: Colors.amberAccent,
        ),
        Container(
          width: 160.0,
          height: 300.0,
          color: Colors.green,
        ),
        Container(
          width: 160.0,
          height: 300.0,
          color: Colors.deepPurpleAccent,
        ),
      ],
    );
  }

  /*
   final _text_nova_tarefa = "Cadastrar nova tarefa...";
  final _label_nova_tarefa = "Nova tarefa";

  String errorText = "Preencha o campo";
  String prefix = "R\$";

  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  hintText: _text_nova_tarefa.toString(),
                  labelText: _label_nova_tarefa.toString(),
                  border: const OutlineInputBorder(),
                ),
                onChanged: _onChanged,
                onSubmitted: _onSubmitted,
              ),
              ElevatedButton(
                onPressed: _entrar,
                child: const Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmitted(String text) {
    print(text);
  }

  void _onChanged(String text) {
    print(text);
  }

  void _entrar() {
    String text = _textFieldController.text;
    print(text);
    _textFieldController.text = "_entrar";
  }
   */

}