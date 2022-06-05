import 'package:estatisticas/domain/entities/pesquisasAgregadosByAssuntoSchemaItem.dart';
import 'package:meta/meta.dart';

import 'agregadoItemModel.dart';

class PesquisasAgregadosByAssuntoSchemaItemModel
    extends PesquisasAgregadosByAssuntoSchemaItem {
  PesquisasAgregadosByAssuntoSchemaItemModel(
      {@required String id,
      @required String nome,
      @required List<AgregadoItemModel> agregados})
      : super(id: id, nome: nome, agregados: agregados);

  factory PesquisasAgregadosByAssuntoSchemaItemModel.fromJson(
      Map<String, dynamic> json) {
    print("PesquisasAgregadosByAssuntoSchemaItemModel json=$json");
    var itemList = <AgregadoItemModel>[];
    json['agregados'].forEach((v) {
      itemList.add(AgregadoItemModel.fromJson(v));
    });

    return PesquisasAgregadosByAssuntoSchemaItemModel(
        id: json['id'], nome: json['nome'], agregados: itemList);
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'variavel': variavel,
  //     'unidade': unidade,
  //     'resultados': resultados.map((e) => e.toJson()).toList()
  //   };
  // }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
