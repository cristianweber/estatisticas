import 'package:estatisticas/domain/entities/serie.dart';
import 'package:meta/meta.dart';

// Objeto no qual as chaves e o valores das propriedades correspondem
// aos períodos pesquisados e seus respectivos resultados

class SerieModel extends Serie {
  SerieModel({@required Map<String, dynamic> item}) : super(item: item);

  factory SerieModel.fromJson(Map<String, dynamic> json) {
    print("SerieModel.fromJson json=$json");
    print("SerieModel.fromJson json['serie']=$json['serie']");
    // var serieList = <Map<String, String>>[];
    // json['serie'].forEach((v) {
    //   serieList.add(v);
    // });
    return SerieModel(item: json);
  }

  Map<String, dynamic> toJson() {
    return {'items': ''}; //todo
  }

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
