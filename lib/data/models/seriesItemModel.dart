import 'package:estatisticas/data/models/localidadeModel.dart';
import 'package:estatisticas/data/models/serieModel.dart';
import 'package:estatisticas/domain/entities/seriesItem.dart';
import 'package:meta/meta.dart';

// Array de séries históricas em que cada objeto armazena uma localidade
// e sua respectiva série

class SeriesItemModel extends SeriesItem {
  SeriesItemModel(
      {@required LocalidadeModel localidade, @required SerieModel serie})
      : super(localidade: localidade, serie: serie);

  factory SeriesItemModel.fromJson(Map<String, dynamic> json) {
    return SeriesItemModel(
        localidade: LocalidadeModel.fromJson(json['localidade']),
        serie: SerieModel.fromJson(json['serie']));
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'localidade': localidade.toJson(),
  //     'serie': serie.toJson(),
  //   };
  // } //todo

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
