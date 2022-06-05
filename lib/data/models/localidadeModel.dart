import 'package:estatisticas/data/models/nivelModel.dart';
import 'package:estatisticas/domain/entities/localidade.dart';
import 'package:estatisticas/domain/entities/nivel.dart';
import 'package:meta/meta.dart';

class LocalidadeModel extends Localidade {
  LocalidadeModel(
      {@required String id, @required Nivel nivel, @required String nome})
      : super(id: id, nivel: nivel, nome: nome);

  factory LocalidadeModel.fromJson(Map<String, dynamic> json) {
    return LocalidadeModel(
        id: json['id'],
        nivel: NivelModel.fromJson(json['nivel']),
        nome: json['nome']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nivel': nivel, 'nome': nome};
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
