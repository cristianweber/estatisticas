import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:estatisticas/core/constants.dart';
import 'package:estatisticas/core/error/failures.dart';
import 'package:estatisticas/data/models/pair_model.dart';
import 'package:estatisticas/domain/usecases/get_pesquisas_agregados_by_assunto.dart';
import 'package:meta/meta.dart';

part 'agregado_ibge_event.dart';
part 'agregado_ibge_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class AgregadoIbgeBloc extends Bloc<AgregadoIgbeEvent, AgregadoIgbeState> {
  //final GetVariaveisByAgregadoIdVariavel getVariaveisByAgregadoIdVariavel;
  final GetPesquisasAgregadosByAssunto getPesquisasAgregadosByAssunto;

  AgregadoIbgeBloc({
    @required GetPesquisasAgregadosByAssunto getPesquisasAgregadosByAssunto,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(getPesquisasAgregadosByAssunto != null),
        getPesquisasAgregadosByAssunto = getPesquisasAgregadosByAssunto;

  @override
  AgregadoIgbeState get initialState => AgregadoInitial();

  @override
  Stream<AgregadoIgbeState> mapEventToState(AgregadoIgbeEvent event) async* {
    if (event is AssuntoSelecionado) {
      yield AgregadosWaiting();

      //todo: chamar caso de uso que carrega da API a lista de pesquisas e agregados a partir do assunto selecionado
      final failureOrSchema = await getPesquisasAgregadosByAssunto(
        GetPesquisasAgregadosByAssuntoParams(assuntoId: event.assuntoId),
      );

      print("failureOrUid2 = $failureOrSchema");

      yield failureOrSchema.fold(
        (failure) => AgregadoError(message: _mapFailureToMessage(failure)),
        (schema) {
          List<PairModel> agregados = [];
          // schema.map((e) => e.agregados
          //     .map((i) => agregados.add(PairModel(id: i.id, nome: i.nome))));
          schema.forEach((element) {
            element.agregados.forEach((i) {
              agregados.add(PairModel(id: i.id, nome: i.nome));
            });
          });

          print(agregados);
          return PesquisasLoaded(
              pesquisas:
                  schema.map((e) => PairModel(id: e.id, nome: e.nome)).toList(),
              agregados: agregados);
        },
        //PesquisasLoaded(
        //  pesquisas: schema.ma.getPesquisas(), agregados: schema.getAgregados()),
      );

      // yield PesquisasLoaded(
      //     pesquisas: PESQUISAS_AGREGADOS,
      //     agregados:
      //         AGREGADOS_AGREGADOS); //todo: trocar PESQUISAS_AGREGADOS e AGREGADOS_AGREGADOS pelo o que vem do caso de uso acima
    }
    if (event is PesquisaSelecionada) {
      //yield AgregadosWaiting();

      //todo: filtrar da lista de agregados somente os agregados correpondentes à pesquisa selecionada

      yield AgregadosLoaded(
          agregados:
              AGREGADOS_AGREGADOS); //todo: trocar AGREGADOS_AGREGADOS pelo o que vem do filtro acima

      // yield failureOrId.fold(
      //   (failure) => AgregadoError(message: _mapFailureToMessage(failure)),
      //   (listOfAgregadoIdVariavelSchema) => AgregadoLoaded(
      //       listOfAgregadoIdVariavelSchema: listOfAgregadoIdVariavelSchema),
      // );
    }
    if (event is AgregadoSelecionado) {
      //yield AgregadosWaiting();

      //todo: chama o caso de uso que gera uma consulta via api aos metadados do agregado, passando como parâmetro
      //todo: o id do agregado selecionado e retorna os metadados do agregado, que serão usados preenchimento dos demais campos do formulário.

      yield MetadadosLoaded(
          //    schema: AGREGADOS_AGREGADOS
          ); //todo: https://servicodados.ibge.gov.br/api/docs/agregados?versao=3#responses-agregadosAgregadoMetadadosGet-200-schema

      // yield failureOrId.fold(
      //   (failure) => AgregadoError(message: _mapFailureToMessage(failure)),
      //   (listOfAgregadoIdVariavelSchema) => AgregadoLoaded(
      //       listOfAgregadoIdVariavelSchema: listOfAgregadoIdVariavelSchema),
      // );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
