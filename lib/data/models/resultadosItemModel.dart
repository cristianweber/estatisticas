import 'package:estatisticas/data/models/classificacoesItemModel.dart';
import 'package:estatisticas/data/models/seriesItemModel.dart';
import 'package:estatisticas/domain/entities/resultadosItem.dart';
import 'package:meta/meta.dart';

class ResultadosItemModel extends ResultadosItem {
  ResultadosItemModel(
      {@required List<ClassificacoesItemModel> classificacoes,
      @required List<SeriesItemModel> series})
      : super(classificacoes: classificacoes, series: series);

  factory ResultadosItemModel.fromJson(Map<String, dynamic> json) {
    var classificacoesList = <ClassificacoesItemModel>[];
    var seriesList = <SeriesItemModel>[];

    print(
        "ResultadosItemModel.fromJson json['classificacoes']=$json['classificacoes']");

    json['classificacoes'].forEach((v) {
      classificacoesList.add(ClassificacoesItemModel.fromJson(v));
    });

    print("ResultadosItemModel.fromJson json['series']=$json['series']");

    json['series'].forEach((v) {
      seriesList.add(SeriesItemModel.fromJson(v));
    });

    print("ResultadosItemModel.fromJson classificacoes=$classificacoesList");
    print("ResultadosItemModel.fromJson series=$seriesList");

    var ret = ResultadosItemModel(
        classificacoes: classificacoesList, series: seriesList);

    print("ResultadosItemModel.fromJson ret=$ret");

    return ret;
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'classificacoes': classificacoes.map((e) => e.toJson()).toList(),
  //     'series': series.map((e) => e.toJson()).toList(),
  //   };
  // }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
