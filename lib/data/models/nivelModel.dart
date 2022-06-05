import 'package:estatisticas/domain/entities/nivel.dart';
import 'package:meta/meta.dart';

class NivelModel extends Nivel {
  NivelModel({@required String id, @required String nome})
      : super(id: id, nome: nome);

  factory NivelModel.fromJson(Map<String, dynamic> json) {
    return NivelModel(id: json['id'], nome: json['nome']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome};
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
