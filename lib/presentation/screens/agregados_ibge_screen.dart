// ignore_for_file: deprecated_member_use

import 'package:estatisticas/core/constants.dart';
import 'package:estatisticas/data/models/pair_model.dart';
import 'package:estatisticas/domain/entities/nivelTerritorial.dart';
import 'package:estatisticas/domain/entities/periodicidade.dart';
import 'package:estatisticas/domain/entities/variavel.dart';
import 'package:estatisticas/presentation/bloc/agregado_ibge/agregado_agregado_ibge/agregado_agregado_ibge_bloc.dart';
import 'package:estatisticas/presentation/bloc/agregado_ibge/localidade_agregado_ibge/localidade_agregado_ibge_bloc.dart';
import 'package:estatisticas/presentation/bloc/agregado_ibge/metadatos_agregado_ibge/metadados_agregado_ibge_bloc.dart';
import 'package:estatisticas/presentation/bloc/agregado_ibge/pesquisa_agregado_ibge/pesquisa_agregado_ibge_bloc.dart';
import 'package:estatisticas/presentation/widgets/message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgregadosIbgeScreen extends StatefulWidget {
  @override
  _AgregadosIbgeScreenState createState() => _AgregadosIbgeScreenState();
}

class _AgregadosIbgeScreenState extends State<AgregadosIbgeScreen> {
  final _formKey = GlobalKey<FormState>();

  // final _formData = Map<String, Object>();

  var _currentAssuntoValue,
      _currentPesquisaValue,
      _currentAgregadoValue,
      _currentVariavelValue,
      _currentPeriodoValue,
      _currentNivelGeograficoValue,
      _currentLocalidadeValue;

  @override
  Widget build(BuildContext context) {
    //final format = DateFormat("dd/MM/yyyy");
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          titleTextStyle: new TextStyle(
              fontSize: 20,
              fontFamily: "Helvetica",
              fontWeight: FontWeight.bold),
          title: Text("Agregados IBGE")),
      body: SingleChildScrollView(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //******************************************** ASSUNTOS */
                    Text("Assuntos:"),
                    FormField<int>(
                      builder: (FormFieldState<int> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              //labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 16.0),
                              hintText: 'Selecione um Assunto para pesquisar',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                          isEmpty: _currentAssuntoValue == 0,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _currentAssuntoValue,
                              isDense: true,
                              onChanged: (String newValue) {
                                print(
                                    "_currentAssuntoValue = $_currentAssuntoValue");
                                setState(() {
                                  _currentAssuntoValue = newValue;
                                });
                                print(
                                    "_currentAssuntoValue = $_currentAssuntoValue");
                                BlocProvider.of<PesquisaAgregadoIbgeBloc>(
                                        context)
                                    .add(PesquisaAssuntoSelecionado(newValue));
                                setState(() {
                                  _currentPesquisaValue = null;
                                  _currentAgregadoValue = null;
                                  _currentVariavelValue = null;
                                  _currentPeriodoValue = null;
                                  _currentNivelGeograficoValue = null;
                                  _currentLocalidadeValue = null;
                                });
                              },
                              // print(
                              //     "_currentSelectedValue=$_currentSelectedValue");
                              //BlocProvider.of<ConsumidorBloc>(context)
                              //     .add(NovoConsumidorEvent(novoConsumidor));
                              items: ASSUNTOS_AGREGADOS.map((PairModel item) {
                                return DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(item.nome),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                    //************************************** PESQUISAS */
                    BlocBuilder<PesquisaAgregadoIbgeBloc,
                        PesquisaAgregadoIgbeState>(builder: (context2, state2) {
                      print('PesquisaAgregadoIgbeState=$state2');
                      if (state2 is PesquisaAgregadoError) {
                        return MessageDisplay(
                          message: state2.message,
                        );
                      } else if (state2 is PesquisaAgregadoLoaded) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text("Pesquisas:"),
                              FormField<int>(
                                builder: (FormFieldState<int> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        //labelStyle: textStyle,
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        hintText: 'Selecione uma pesquisa',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    isEmpty: _currentPesquisaValue == 0,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _currentPesquisaValue,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _currentPesquisaValue = newValue;
                                            _currentAgregadoValue = null;
                                          });
                                          print(
                                              "_currentPesquisaValue=$_currentPesquisaValue");

                                          BlocProvider.of<
                                                      AgregadoAgregadoIbgeBloc>(
                                                  context)
                                              .add(AgregadoPesquisaSelecionado(
                                                  newValue, state2.agregados));
                                        },
                                        items: state2.pesquisas
                                            .map((PairModel item) {
                                          return DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(item.nome),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ]);
                      } else
                        return Text('');
                    }),
                    //***************************************** AGREGADOS */
                    BlocBuilder<AgregadoAgregadoIbgeBloc,
                        AgregadoAgregadoIgbeState>(builder: (context2, state2) {
                      print('AgregadoAgregadoIgbeState=$state2');
                      if (state2 is AgregadoAgregadoError) {
                        return MessageDisplay(
                          message: state2.message,
                        );
                      } else if (state2 is AgregadoAgregadosWaiting) {
                        return Text('oi');
                      } else if (state2 is AgregadoAgregadosLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text("Agregados (Séries cadastradas):"),
                            FormField<int>(
                              builder: (FormFieldState<int> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                      //labelStyle: textStyle,
                                      errorStyle: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16.0),
                                      hintText: 'Selecione um agregado',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  isEmpty: _currentAgregadoValue == 0,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: _currentAgregadoValue,
                                      menuMaxHeight: 60,
                                      elevation: 38,

                                      //isDense: true,
                                      onChanged: (String newValue) {
                                        print(
                                            'Agregado selectionado id=$newValue');
                                        setState(() {
                                          _currentAgregadoValue = newValue;
                                        });
                                        BlocProvider.of<
                                                    MetadadosAgregadoIbgeBloc>(
                                                context)
                                            .add(AgregadoSelecionado(newValue));
                                      },
                                      // print(
                                      //     "_currentSelectedValue=$_currentSelectedValue");
                                      //BlocProvider.of<ConsumidorBloc>(context)
                                      //     .add(NovoConsumidorEvent(novoConsumidor));
                                      items: state2.agregados
                                          .map((PairModel item) {
                                        return DropdownMenuItem<String>(
                                          value: item.id,
                                          child: Text(item.nome,
                                              overflow: TextOverflow.clip),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ); //todo: trocar PESQUISAS_AGREGADOS para o que vem da busca na API do IBGE: state.pesquisas
                      } else
                        return Text('');
                    }),
                    //***************************************** METADADOS */
                    BlocBuilder<MetadadosAgregadoIbgeBloc,
                            MetadadosAgregadoIgbeState>(
                        builder: (context2, state2) {
                      print('MetadadosAgregadoIbgeBloc=$state2');
                      if (state2 is MetadadosAgregadoError) {
                        return MessageDisplay(
                          message: state2.message,
                        );
                      } else if (state2 is MetadadosAgregadoWaiting) {
                        return Text('processando...');
                      } else if (state2 is MetadadosAgregadoLoaded) {
                        print("periodicidade=${state2.schema.periodicidade}");
                        List<PairModel> periodos =
                            parserPeriodos(state2.schema.periodicidade);

                        List<PairModel> nivelGeografico = parserNivelGeografico(
                            state2.schema.nivelTerritorial);

                        print("periodos=$periodos");

                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text("Variáveis:"),
                              FormField<int>(
                                builder: (FormFieldState<int> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        //labelStyle: textStyle,
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        hintText: 'Selecione uma variável',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    isEmpty: _currentVariavelValue == 0,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _currentVariavelValue,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _currentVariavelValue = newValue;
                                          });
                                          print(
                                              "_currentVariavelValue=$_currentVariavelValue");
                                          // BlocProvider.of<AgregadoIbgeBloc>(
                                          //         context)
                                          //     .add(VariavelSelecionada(
                                          //         newValue));
                                        },
                                        items: state2.schema.variaveis
                                            .map((Variavel item) {
                                          return DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(item.nome,
                                                overflow: TextOverflow.clip),
                                          );
                                        }).toList(),
                                        // state2.pesquisas
                                        //     .map((PairModel item) {
                                        //   return DropdownMenuItem<String>(
                                        //     value: item.id,
                                        //     child: Text(item.nome),
                                        //   );
                                        // }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Períodos:"),
                              FormField<int>(
                                builder: (FormFieldState<int> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        //labelStyle: textStyle,
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        hintText: 'Selecione um período',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    isEmpty: _currentAgregadoValue == 0,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: _currentPeriodoValue,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _currentPeriodoValue = newValue;
                                          });
                                          // BlocProvider.of<
                                          //             AgregadoIbgeBloc>(
                                          //         context)
                                          //     .add(PeriodoSelecionado(
                                          //         newValue));
                                        },
                                        // print(
                                        //     "_currentSelectedValue=$_currentSelectedValue");
                                        //BlocProvider.of<ConsumidorBloc>(context)
                                        //     .add(NovoConsumidorEvent(novoConsumidor));
                                        items: periodos.map((dynamic item) {
                                          return DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(item.nome,
                                                overflow: TextOverflow.clip),
                                          );
                                        }).toList(),
                                        // state2.agregados
                                        //     .map((PairModel item) {
                                        //   return DropdownMenuItem<String>(
                                        //     value: item.id,
                                        //     child: Text(item.nome),
                                        //   );
                                        // }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Nível Geográfico:"),
                              FormField<int>(
                                builder: (FormFieldState<int> state) {
                                  return InputDecorator(
                                    decoration: InputDecoration(
                                        //labelStyle: textStyle,
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        hintText:
                                            'Selecione um nível geográfico',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                    isEmpty: _currentAgregadoValue == 0,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: _currentNivelGeograficoValue,
                                        isDense: true,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _currentNivelGeograficoValue =
                                                newValue;
                                          });
                                          _currentLocalidadeValue = null;
                                          BlocProvider.of<
                                                      LocalidadeAgregadoIbgeBloc>(
                                                  context)
                                              .add(NivelGeograficoSelecionado(
                                                  _currentAgregadoValue,
                                                  _currentNivelGeograficoValue));
                                          // BlocProvider.of<
                                          //             AgregadoIbgeBloc>(
                                          //         context)
                                          //     .add(PeriodoSelecionado(
                                          //         newValue));
                                        },
                                        // print(
                                        //     "_currentSelectedValue=$_currentSelectedValue");
                                        //BlocProvider.of<ConsumidorBloc>(context)
                                        //     .add(NovoConsumidorEvent(novoConsumidor));
                                        items:
                                            nivelGeografico.map((dynamic item) {
                                          return DropdownMenuItem<String>(
                                            value: item.id,
                                            child: Text(item.nome,
                                                overflow: TextOverflow.clip),
                                          );
                                        }).toList(),
                                        // state2.agregados
                                        //     .map((PairModel item) {
                                        //   return DropdownMenuItem<String>(
                                        //     value: item.id,
                                        //     child: Text(item.nome),
                                        //   );
                                        // }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<LocalidadeAgregadoIbgeBloc,
                                      LocalidadeAgregadoIgbeState>(
                                  builder: (context3, state3) {
                                print('LocalidadeAgregadoIgbeState=$state3');
                                if (state3 is LocalidadeAgregadoError) {
                                  return MessageDisplay(
                                    message: state3.message,
                                  );
                                } else if (state3
                                    is LocalidadeAgregadoWaiting) {
                                  return Text('processando');
                                } else if (state3 is LocalidadeAgregadoLoaded) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text("Localidades:"),
                                      FormField<int>(
                                        builder: (FormFieldState<int> state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                                //labelStyle: textStyle,
                                                errorStyle: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 16.0),
                                                hintText:
                                                    'Selecione uma localidade',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0))),
                                            isEmpty:
                                                _currentLocalidadeValue == 0,
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: _currentLocalidadeValue,
                                                isDense: true,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    _currentLocalidadeValue =
                                                        newValue;
                                                  });
                                                  // BlocProvider.of<
                                                  //             AgregadoIbgeBloc>(
                                                  //         context)
                                                  //     .add(PeriodoSelecionado(
                                                  //         newValue));
                                                },
                                                // print(
                                                //     "_currentSelectedValue=$_currentSelectedValue");
                                                //BlocProvider.of<ConsumidorBloc>(context)
                                                //     .add(NovoConsumidorEvent(novoConsumidor));
                                                items: state3.localidades
                                                    .map((dynamic item) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: item.id,
                                                    child: Text(item.nome,
                                                        overflow:
                                                            TextOverflow.clip),
                                                  );
                                                }).toList(),
                                                // state2.agregados
                                                //     .map((PairModel item) {
                                                //   return DropdownMenuItem<String>(
                                                //     value: item.id,
                                                //     child: Text(item.nome),
                                                //   );
                                                // }).toList(),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ); //todo: trocar PESQUISAS_AGREGADOS para o que vem da busca na API do IBGE: state.pesquisas
                                } else
                                  return Text('');
                              })
                            ]);
                      } else
                        return Text('');
                      // if (state2 is MetadadosLoaded) {
                      //   return BlocProvider.value(
                      //       value:
                      //           BlocProvider.of<AgregadoIbgeBloc>(context2),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           SizedBox(
                      //             height: 15,
                      //           ),
                      //           Text("Variáveis:"),
                      //           FormField<int>(
                      //             builder: (FormFieldState<int> state) {
                      //               return InputDecorator(
                      //                 decoration: InputDecoration(
                      //                     //labelStyle: textStyle,
                      //                     errorStyle: TextStyle(
                      //                         color: Colors.redAccent,
                      //                         fontSize: 16.0),
                      //                     hintText: 'Selecione uma variável',
                      //                     border: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 5.0))),
                      //                 isEmpty: _currentPesquisaValue == 0,
                      //                 child: DropdownButtonHideUnderline(
                      //                   child: DropdownButton<String>(
                      //                     value: _currentPesquisaValue,
                      //                     onChanged: (String newValue) {
                      //                       BlocProvider.of<AgregadoIbgeBloc>(
                      //                               context)
                      //                           .add(VariavelSelecionada(
                      //                               newValue));
                      //                     },
                      //                     items: null,
                      //                     // state2.pesquisas
                      //                     //     .map((PairModel item) {
                      //                     //   return DropdownMenuItem<String>(
                      //                     //     value: item.id,
                      //                     //     child: Text(item.nome),
                      //                     //   );
                      //                     // }).toList(),
                      //                   ),
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //           SizedBox(
                      //             height: 15,
                      //           ),
                      //           Text("Períodos:"),
                      //           FormField<int>(
                      //             builder: (FormFieldState<int> state) {
                      //               return InputDecorator(
                      //                 decoration: InputDecoration(
                      //                     //labelStyle: textStyle,
                      //                     errorStyle: TextStyle(
                      //                         color: Colors.redAccent,
                      //                         fontSize: 16.0),
                      //                     hintText: 'Selecione um período',
                      //                     border: OutlineInputBorder(
                      //                         borderRadius:
                      //                             BorderRadius.circular(
                      //                                 5.0))),
                      //                 isEmpty: _currentAgregadoValue == 0,
                      //                 child: DropdownButtonHideUnderline(
                      //                   child: DropdownButton<String>(
                      //                       isExpanded: true,
                      //                       value: _currentAgregadoValue,
                      //                       isDense: true,
                      //                       onChanged: (String newValue) {
                      //                         BlocProvider.of<
                      //                                     AgregadoIbgeBloc>(
                      //                                 context)
                      //                             .add(PeriodoSelecionado(
                      //                                 newValue));
                      //                       },
                      //                       // print(
                      //                       //     "_currentSelectedValue=$_currentSelectedValue");
                      //                       //BlocProvider.of<ConsumidorBloc>(context)
                      //                       //     .add(NovoConsumidorEvent(novoConsumidor));
                      //                       items: null
                      //                       // state2.agregados
                      //                       //     .map((PairModel item) {
                      //                       //   return DropdownMenuItem<String>(
                      //                       //     value: item.id,
                      //                       //     child: Text(item.nome),
                      //                       //   );
                      //                       // }).toList(),
                      //                       ),
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ],
                      //       )); //todo: trocar PESQUISAS_AGREGADOS para o que vem da busca na API do IBGE: state.pesquisas
                      // } else
                      //   return Text('');
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PairModel> parserPeriodos(Periodicidade periodicidade) {
    List<PairModel> ret = [];
    if (periodicidade.frequencia == "anual") {
      for (var i = int.parse(periodicidade.inicio);
          i <= int.parse(periodicidade.fim);
          i++) {
        ret.add(PairModel(
            id: i.toString(), nome: i.toString() + " - " + i.toString()));
      }
    }
    //fazer para as outras frequencias de periodicidade
    return ret;
  }

  List<PairModel> parserNivelGeografico(NivelTerritorial nivelTerritorial) {
    List<PairModel> ret = [];
    nivelTerritorial.administrativo
        .forEach((element) => ret.add(PairModel(id: element, nome: element)));
    nivelTerritorial.especial
        .forEach((element) => ret.add(PairModel(id: element, nome: element)));
    nivelTerritorial.ibge
        .forEach((element) => ret.add(PairModel(id: element, nome: element)));
    return ret;
  }

  // _sendToServer(BuildContext context) {
  //   //print("_sendToServer x");
  //   //if (_formKey.currentState.validate()) {
  //   _formKey.currentState.save();

  //   print("_formData['email'] = " + _formData['email']);
  //   print("_formData['senha'] = " + _formData['senha']);
  //   print("_formData['nome'] = " + _formData['nome']);
  //   print("_formData['cpf'] = " + _formData['cpf']);
  //   print("_formData['fone'] = " + _formData['fone']);
  //   print("_formData['endereco'] = " + _formData['endereco']);

  //   // final novoConsumidor = Consumidor(
  //   //     email: _formData['email'],
  //   //     senha: _formData['senha'],
  //   //     nome: _formData['nome'],
  //   //     cpf: _formData['cpf'],
  //   //     fone: _formData['fone'],
  //   //     tipo: _formData['tipo'],
  //   //     endereco: _formData['endereco']);

  //   // BlocProvider.of<ConsumidorBloc>(context)
  //   //     .add(NovoConsumidorEvent(novoConsumidor));

  //   //_formKey.currentState.reset();
  //   Navigator.pop(context);
  // }
}
