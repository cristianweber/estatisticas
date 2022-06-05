import 'package:estatisticas/domain/entities/variavel.dart';
import 'package:meta/meta.dart';

// From: https://servicodados.ibge.gov.br/api/docs/agregados?versao=3#api-Metadados-agregadosAgregadoMetadadosGet

class VariavelModel extends Variavel {
  VariavelModel(
      {@required String id,
      @required String nome,
      @required String unidade,
      @required List<String> sumarizacao})
      : super(id: id, nome: nome, unidade: unidade, sumarizacao: sumarizacao);

  factory VariavelModel.fromJson(Map<String, dynamic> json) {
    var sumarizacaoList = <String>[];

    json['sumarizacao'].forEach((v) {
      sumarizacaoList.add(v);
    });

    return VariavelModel(
        id: json['id'].toString(),
        nome: json['nome'],
        unidade: json['unidade'],
        sumarizacao: sumarizacaoList);
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
