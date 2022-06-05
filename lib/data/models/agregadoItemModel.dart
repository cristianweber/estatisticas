import 'package:estatisticas/domain/entities/agregadoItem.dart';
import 'package:meta/meta.dart';

class AgregadoItemModel extends AgregadoItem {
  AgregadoItemModel({@required String id, @required String nome})
      : super(id: id, nome: nome);

  factory AgregadoItemModel.fromJson(Map<String, dynamic> json) {
    return AgregadoItemModel(id: json['id'], nome: json['nome']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome};
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
