import 'package:equatable/equatable.dart';
import 'package:estatisticas/domain/entities/localidade.dart';
import 'package:estatisticas/domain/entities/serie.dart';
import 'package:meta/meta.dart';

// Array de séries históricas em que cada objeto armazena uma localidade
// e sua respectiva série

class SeriesItem extends Equatable {
  final Localidade localidade;
  final Serie serie;

  SeriesItem({@required this.localidade, @required this.serie});

  @override
  String toString() => '$localidade, $serie';

  @override
  List<Object> get props => [localidade, serie];
}
