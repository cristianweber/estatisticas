import 'package:estatisticas/data/models/categoriaModel.dart';
import 'package:estatisticas/data/models/sumarizacaoModel.dart';
import 'package:estatisticas/domain/entities/categoria.dart';
import 'package:estatisticas/domain/entities/classificacao.dart';
import 'package:estatisticas/domain/entities/sumarizacao.dart';
import 'package:meta/meta.dart';

// From: https://servicodados.ibge.gov.br/api/docs/agregados?versao=3#api-Metadados-agregadosAgregadoMetadadosGet

class ClassificacaoModel extends Classificacao {
  ClassificacaoModel({
    @required String id,
    @required String nome,
    @required Sumarizacao sumarizacao,
    @required List<Categoria> categorias,
  }) : super(
            id: id,
            nome: nome,
            sumarizacao: sumarizacao,
            categorias: categorias);

  factory ClassificacaoModel.fromJson(Map<String, dynamic> json) {
    var list = <CategoriaModel>[];
    json['categorias'].forEach((v) {
      list.add(CategoriaModel.fromJson(v));
    });

    return ClassificacaoModel(
        id: json['id'],
        nome: json['nome'],
        sumarizacao: SumarizacaoModel.fromJson(json['sumarizacao']),
        categorias: list);
  }

  // Map<String, dynamic> toJson() {
  //   //todo
  // }
}
