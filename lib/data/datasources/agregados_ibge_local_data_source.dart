import 'dart:convert';
import 'package:estatisticas/core/error/exception.dart';
import 'package:estatisticas/data/models/agregadoIdVariavelSchemaItem_model.dart';
import 'package:estatisticas/data/models/metadadosSchema_model.dart';
import 'package:estatisticas/domain/entities/localidade.dart';
import 'package:estatisticas/domain/entities/metadadosSchema.dart';
import 'package:estatisticas/domain/entities/pesquisasAgregadosByAssuntoSchemaItem.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AgregadosIbgeLocalDataSource {
  /// Gets the cached [MedicamentoModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<AgregadoIdVariavelSchemaItemModel>
      getLastAgregadoIdVariavelSchemaItem();

  Future<void> cacheAgregadoIdVariavelSchemaItem(
      AgregadoIdVariavelSchemaItemModel recordToCache);

  Future<List<AgregadoIdVariavelSchemaItemModel>>
      getLastListOfAgregadoIdVariavelSchemaItem();

  Future<void> cacheListOfAgregadoIdVariavelSchemaItem(
      List<AgregadoIdVariavelSchemaItemModel>
          listOfAgregadoIdVariavelSchemaItemToCache);

  Future<void> cacheListOfPesquisasAgregadosByAssuntoSchemaItem(
      List<PesquisasAgregadosByAssuntoSchemaItem>
          listOfPesquisasAgregadosByAssuntoSchemaItem);

  Future<List<PesquisasAgregadosByAssuntoSchemaItem>>
      getLastListOfPesquisasAgregadosByAssuntoSchemaItem();

  Future<void> cacheMetadadosSchema(MetadadosSchemaModel metadadosSchema);

  Future<void> cacheLocalidades(List<Localidade> localidades);

  Future<List<Localidade>> getLastListOfLocalidade();

  Future<MetadadosSchema> getLastMetadadosSchema();
}

const CACHED_RECORD = 'CACHED_RECORD';

class AgregadosIbgeLocalDataSourceImpl implements AgregadosIbgeLocalDataSource {
  final SharedPreferences sharedPreferences;

  AgregadosIbgeLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheMetadadosSchema(
      MetadadosSchemaModel metadadosSchema) async {
    // return sharedPreferences.setString(
    //   CACHED_RECORD,
    //   json.encode(metadadosSchema.toJson()),
    // );
  }

  @override
  Future<void> cacheLocalidades(List<Localidade> localidades) async {}

  @override
  Future<MetadadosSchema> getLastMetadadosSchema() {
    final jsonString = sharedPreferences.getString(CACHED_RECORD);
    if (jsonString != null) {
      return Future.value(
          MetadadosSchemaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<Localidade>> getLastListOfLocalidade() {
    // final jsonString = sharedPreferences.getString(CACHED_RECORD);
    // if (jsonString != null) {
    //   return Future.value(
    //       LocalidadeModel.fromJson(json.decode(jsonString)));
    // } else {
    //   throw CacheException();
    // }
    return null;
  }

  @override
  Future<AgregadoIdVariavelSchemaItemModel>
      getLastAgregadoIdVariavelSchemaItem() {
    final jsonString = sharedPreferences.getString(CACHED_RECORD);
    if (jsonString != null) {
      return Future.value(
          AgregadoIdVariavelSchemaItemModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheAgregadoIdVariavelSchemaItem(
      AgregadoIdVariavelSchemaItemModel recordToCache) async {
    // return sharedPreferences.setString(
    //   CACHED_RECORD,
    //   json.encode(recordToCache.toJson()),
    // ); //todo
  }

  @override
  Future<List<AgregadoIdVariavelSchemaItemModel>>
      getLastListOfAgregadoIdVariavelSchemaItem() {
    // ignore: todo
    // TODO: implement getLastListOfMedicamentos
    return null;
  }

  @override
  Future<void> cacheListOfAgregadoIdVariavelSchemaItem(
      List<AgregadoIdVariavelSchemaItemModel>
          listOfAgregadoIdVariavelSchemaItemToCache) {
    // ignore: todo
    // TODO: implement cacheListOfMedicamentos
    return null;
  }

  @override
  Future<List<PesquisasAgregadosByAssuntoSchemaItem>>
      getLastListOfPesquisasAgregadosByAssuntoSchemaItem() {
    // ignore: todo
    // TODO: implement getLastListOfPesquisasAgregadosByAssuntoSchemaItem
    return null;
  }

  @override
  Future<void> cacheListOfPesquisasAgregadosByAssuntoSchemaItem(
      List<PesquisasAgregadosByAssuntoSchemaItem>
          listOfPesquisasAgregadosByAssuntoSchemaItem) {
    // ignore: todo
    // TODO: implement cacheListOfPesquisasAgregadosByAssuntoSchemaItem
    return null;
  }
}
