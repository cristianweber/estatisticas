import 'package:estatisticas/data/models/resultadosItemModel.dart';
import 'package:estatisticas/domain/entities/agregadoIdVariavelSchemaItem.dart';
import 'package:meta/meta.dart';

class AgregadoIdVariavelSchemaItemModel extends AgregadoIdVariavelSchemaItem {
  AgregadoIdVariavelSchemaItemModel(
      {@required String id,
      @required String variavel,
      @required String unidade,
      @required List<ResultadosItemModel> resultados})
      : super(
            id: id,
            variavel: variavel,
            unidade: unidade,
            resultados: resultados);

  factory AgregadoIdVariavelSchemaItemModel.fromJson(
      Map<String, dynamic> json) {
    print("AgregadoIdVariavelSchemaItemModel json=$json");
    var resuldadosItemList = <ResultadosItemModel>[];
    json['resultados'].forEach((v) {
      resuldadosItemList.add(ResultadosItemModel.fromJson(v));
    });

    print(
        "AgregadoIdVariavelSchemaItemModel resuldadosItemList=$resuldadosItemList");

    print("AgregadoIdVariavelSchemaItemModel json['id']=$json['id']");
    print(
        "AgregadoIdVariavelSchemaItemModel json['variavel']=$json['variavel']");
    print("AgregadoIdVariavelSchemaItemModel json['unidade']=$json['unidade']");

    return AgregadoIdVariavelSchemaItemModel(
        id: json['id'],
        variavel: json['variavel'],
        unidade: json['unidade'],
        resultados: resuldadosItemList);
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
