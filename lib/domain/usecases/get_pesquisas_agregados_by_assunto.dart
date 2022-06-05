import 'package:dartz/dartz.dart';
import 'package:estatisticas/domain/entities/pesquisasAgregadosByAssuntoSchemaItem.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:estatisticas/core/error/failures.dart';
import 'package:estatisticas/core/usecases/usecase.dart';
import 'package:estatisticas/domain/repositories/agregados_ibge_repository.dart';

class GetPesquisasAgregadosByAssunto extends UseCase<
    List<PesquisasAgregadosByAssuntoSchemaItem>,
    GetPesquisasAgregadosByAssuntoParams> {
  final AgregadosIbgeRepository repository;

  GetPesquisasAgregadosByAssunto(this.repository);

  @override
  Future<Either<Failure, List<PesquisasAgregadosByAssuntoSchemaItem>>> call(
      GetPesquisasAgregadosByAssuntoParams params) async {
    return await repository.getPesquisasAgregadosByAssunto(params.assuntoId);
  }
}

class GetPesquisasAgregadosByAssuntoParams extends Equatable {
  final String assuntoId;

  GetPesquisasAgregadosByAssuntoParams({@required this.assuntoId});

  @override
  List<Object> get props => [assuntoId];
}
