import 'package:cdmtarefass/models/tarefas.dart';
import 'package:cdmtarefass/utils/db.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DB.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Tarefas Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tarefas> _tarefas = [];

  List<Widget> get _widgets =>
      _tarefas.map((tarefa) =>
       tarefaWidget(tarefa)).toList();

  Widget tarefaWidget(Tarefas tarefa) {
    Padding(
      padding: EdgeInsets.all(16),
      child: FlatButton(
        child: Row(
          children: <Widget>[
            Text(tarefa.tarefa),
            Icon(tarefa.completo == true
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
                )
          ],
        ),
        onPressed: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: _widgets,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline),
        onPressed: () {
          _addTarefa(context);
        },
      ),
    );
  }

  String _tarefa;

  void _addTarefa(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Adicionar Trefa"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _salvarTrefa(),
              child: Text("Incluir"),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancelar"),
            ),
          ],
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Descrição da tarefa",
              hintText: "ex: Jogar lolzin",
            ),
            onChanged: (valor) {
              _tarefa = valor;
            },
          ),
        );
      },
    );
  }

  _salvarTrefa() async {
    Tarefas tarefa = Tarefas(
      tarefa: _tarefa,
      completo: false,
    );

    await DB.insert(Tarefas.tableName, tarefa);
    setState(() => _tarefa = '');

    Navigator.of(context).pop();
  }
}
