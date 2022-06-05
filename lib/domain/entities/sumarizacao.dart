
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// From: https://servicodados.ibge.gov.br/api/docs/agregados?versao=3#api-Metadados-agregadosAgregadoMetadadosGet

class Sumarizacao extends Equatable {
  final bool status;
  final List<String>
      excecao; //nforma os identificadores das variáveis para as quais não são considerados a categoria Total. Na prática, significa que você deve especificar uma categoria que não seja a (categoria) Total para obter o valor da variável

  Sumarizacao({@required this.status, @required this.excecao});

  @override
  String toString() => '$status, $excecao';

  @override
  List<Object> get props => [status, excecao];
}
