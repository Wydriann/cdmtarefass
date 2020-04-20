import 'package:cdmtarefass/models/base_model.dart';

class Tarefas extends BaseModel{
  static String tableName = "Tarefas";

  int id;
  String tarefa;
  bool completo;

  Tarefas ({this.id, this.tarefa, this.completo});

  static fromMap(Map<String, dynamic> map){
    return Tarefas(
      id: map['id'],
      tarefa: map['tarefa'],
      completo: map['completo'] == 1, 
    );
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'tarefa': tarefa,
      'completo': completo,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}

  