import 'package:estatisticas/domain/entities/classificacoesItem.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class ClassificacoesItemModel extends ClassificacoesItem {
  ClassificacoesItemModel(
      {@required String id,
      @required String nome,
      @required Map<String, dynamic> categoria})
      : super(id: id, nome: nome, categoria: categoria);

  factory ClassificacoesItemModel.fromJson(Map<String, dynamic> json) {
    print("ClassificacoesItemModel.fromJson json['id']=$json['id']");
    print("ClassificacoesItemModel.fromJson json['nome']=$json['nome']");
    print(
        "ClassificacoesItemModel.fromJson json['categoria']=$json['categoria']");
    return ClassificacoesItemModel(
        id: json['id'],
        nome: json['nome'],
        categoria: json['categoria']); //todo
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'categoria': jsonEncode(categoria)};
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
