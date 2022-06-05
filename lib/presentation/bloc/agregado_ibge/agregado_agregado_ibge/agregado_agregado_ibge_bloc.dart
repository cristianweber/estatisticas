import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:estatisticas/core/error/failures.dart';
import 'package:estatisticas/data/models/pair_model.dart';
import 'package:estatisticas/domain/usecases/get_variaveis_by_agregadoIdVariavel.dart';
import 'package:meta/meta.dart';

part 'agregado_agregado_ibge_event.dart';
part 'agregado_agregado_ibge_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class AgregadoAgregadoIbgeBloc
    extends Bloc<AgregadoAgregadoIgbeEvent, AgregadoAgregadoIgbeState> {
  final GetVariaveisByAgregadoIdVariavel getVariaveisByAgregadoIdVariavel;
  //final GetPesquisasAgregadosByAssunto getPesquisasAgregadosByAssunto;

  AgregadoAgregadoIbgeBloc({
    @required GetVariaveisByAgregadoIdVariavel getVariaveisByAgregadoIdVariavel,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(getVariaveisByAgregadoIdVariavel != null),
        getVariaveisByAgregadoIdVariavel = getVariaveisByAgregadoIdVariavel;

  @override
  AgregadoAgregadoIgbeState get initialState => AgregadoInitial();

  @override
  Stream<AgregadoAgregadoIgbeState> mapEventToState(
      AgregadoAgregadoIgbeEvent event) async* {
    if (event is AgregadoPesquisaSelecionado) {
      yield AgregadoAgregadosWaiting();

      //filtrar da lista de agregados somente os agregados correpondentes à pesquisa selecionada
      var agregados = event.agregados
          .where((element) => element.idRel == event.pesquisaId)
          .toList();

      yield AgregadoAgregadosLoaded(agregados: agregados);
    }
  }

  // ignore: unused_element
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
