import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController textEditingController = TextEditingController();
  List<String> listaDeTarefas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Adicione uma tarefa',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          TextField(
            controller: textEditingController,
          ),
          const Text(
            'Lista de tarefas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 400,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    listaDeTarefas[index],
                  ),
                  onLongPress: () {
                    setState(
                      () {
                        listaDeTarefas.removeAt(index);
                      },
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: listaDeTarefas.length,
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (() {
              if (textEditingController.text.isNotEmpty) {
                setState(() {
                  listaDeTarefas.add(textEditingController.text);
                  textEditingController.clear();
                });
              }
            }),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: (() => setState(
                  () {
                    listaDeTarefas = [];
                    textEditingController.clear();
                  },
                )),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
