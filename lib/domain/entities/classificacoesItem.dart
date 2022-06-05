import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ClassificacoesItem extends Equatable {
  final String id; //Identificador da classificação
  final String nome; //Nome da classificação
  final Map<String, dynamic>
      categoria; //Objeto contendo apenas uma propriedade em que a chave e o valor correspondem, respectivamente, ao identificador e nome da categoria

  ClassificacoesItem(
      {@required this.id, @required this.nome, @required this.categoria});

  @override
  String toString() => '$id, $nome, $categoria';

  @override
  List<Object> get props => [id, nome, categoria];
}
