import 'package:estatisticas/domain/entities/sumarizacao.dart';
import 'package:meta/meta.dart';

// From: https://servicodados.ibge.gov.br/api/docs/agregados?versao=3#api-Metadados-agregadosAgregadoMetadadosGet

class SumarizacaoModel extends Sumarizacao {
  SumarizacaoModel({@required bool status, @required List<String> excecao})
      : super(status: status, excecao: excecao);

  factory SumarizacaoModel.fromJson(Map<String, dynamic> json) {
    return SumarizacaoModel(
      status: json['status'],
      excecao: json['excecao'],
    );
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
