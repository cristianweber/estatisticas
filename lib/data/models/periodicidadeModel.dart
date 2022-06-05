import 'package:estatisticas/domain/entities/periodicidade.dart';
import 'package:meta/meta.dart';

// From: https://servicodados.ibge.gov.br/api/docs/agregados?versao=3#api-Metadados-agregadosAgregadoMetadadosGet

class PeriodicidadeModel extends Periodicidade {
  PeriodicidadeModel(
      {@required String frequencia,
      @required String inicio,
      @required String fim})
      : super(frequencia: frequencia, inicio: inicio, fim: fim);

  factory PeriodicidadeModel.fromJson(Map<String, dynamic> json) {
    return PeriodicidadeModel(
        frequencia: json['frequencia'],
        inicio: json['inicio'].toString(),
        fim: json['fim'].toString());
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
