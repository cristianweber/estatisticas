import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// Objeto no qual as chaves e o valores das propriedades correspondem
// aos períodos pesquisados e seus respectivos resultados

class Serie extends Equatable {
  final Map<String, dynamic> item;

  Serie({@required this.item});

  @override
  String toString() => '$item';

  @override
  List<Object> get props => [item];
}
