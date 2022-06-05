import 'package:estatisticas/data/models/classificacaoModel.dart';
import 'package:estatisticas/data/models/nivelTerritorialModel.dart';
import 'package:estatisticas/data/models/periodicidadeModel.dart';
import 'package:estatisticas/data/models/variavelModel.dart';
import 'package:estatisticas/domain/entities/classificacao.dart';
import 'package:estatisticas/domain/entities/metadadosSchema.dart';
import 'package:estatisticas/domain/entities/nivelTerritorial.dart';
import 'package:estatisticas/domain/entities/periodicidade.dart';
import 'package:estatisticas/domain/entities/variavel.dart';
import 'package:meta/meta.dart';

class MetadadosSchemaModel extends MetadadosSchema {
  MetadadosSchemaModel({
    @required String id, //Identificador do agregado
    @required String nome, //Nome do agregado
    @required String url, //Página do Agregado no portal do SIDRA
    @required String pesquisa, //Pesquisa a que pertence o agregado
    @required String assunto, //Assunto informado pelo agregado
    @required Periodicidade periodicidade,
    @required NivelTerritorial nivelTerritorial, //Nível abrangido pelo agregado
    @required List<Variavel> variaveis,
    @required List<Classificacao> classificacoes,
  }) : super(
            id: id,
            nome: nome,
            url: url,
            pesquisa: pesquisa,
            assunto: assunto,
            periodicidade: periodicidade,
            nivelTerritorial: nivelTerritorial,
            variaveis: variaveis,
            classificacoes: classificacoes);

  factory MetadadosSchemaModel.fromJson(Map<String, dynamic> json) {
    print("AgregadoIdVariavelSchemaItemModel json=$json");

    var variaveis = <Variavel>[];

    print('json[variaveis]=${json['variaveis']}');

    json['variaveis'].forEach((v) {
      print('v=$v');
      variaveis.add(VariavelModel.fromJson(v));
    });

    print('variaveis=$variaveis');

    var classificacoes = <Classificacao>[];

    json['classificacoes'].forEach((v) {
      print('v=$v');
      classificacoes.add(ClassificacaoModel.fromJson(v));
    });

    var nivelTerritorial =
        NivelTerritorialModel.fromJson(json['nivelTerritorial']);

    print('nivelTerritorial=$nivelTerritorial');

    var ret = MetadadosSchemaModel(
        id: json['id'].toString(),
        nome: json['nome'],
        url: json['URL'],
        pesquisa: json['pesquisa'],
        assunto: json['assunto'],
        periodicidade: PeriodicidadeModel.fromJson(json['periodicidade']),
        nivelTerritorial:
            NivelTerritorialModel.fromJson(json['nivelTerritorial']),
        variaveis: variaveis,
        classificacoes: classificacoes);

    print('MetadadosSchemaModel=$ret');

    return ret;
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
