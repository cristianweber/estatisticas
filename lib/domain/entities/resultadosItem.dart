import 'package:equatable/equatable.dart';
import 'package:estatisticas/domain/entities/classificacoesItem.dart';
import 'package:estatisticas/domain/entities/seriesItem.dart';
import 'package:meta/meta.dart';

class ResultadosItem extends Equatable {
  final List<ClassificacoesItem> classificacoes;
  final List<SeriesItem> series;

  ResultadosItem({@required this.classificacoes, @required this.series});

  @override
  String toString() => '$classificacoes, $series';

  @override
  List<Object> get props => [classificacoes, series];
}
