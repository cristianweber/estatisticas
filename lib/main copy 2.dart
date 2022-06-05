import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JenisMakananBloc>(
          create: (context) => JenisMakananBloc(),
        ),
        BlocProvider<HewanBloc>(
          create: (context) => HewanBloc(),
        ),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: BlocListener<JenisMakananBloc, int>(
        listener: (context, state) {
          if (state >= 0 && state <= 2) {
            BlocProvider.of<HewanBloc>(context).add(state);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            BlocBuilder<JenisMakananBloc, int>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: state,
                      onChanged: _onChangedRadio,
                    ),
                    Text('Karnivora'),
                    Radio(
                      value: 1,
                      groupValue: state,
                      onChanged: _onChangedRadio,
                    ),
                    Text('Herbivora'),
                    Radio(
                      value: 2,
                      groupValue: state,
                      onChanged: _onChangedRadio,
                    ),
                    Text('Omnivora'),
                  ],
                );
              },
            ),
            WidgetDropdownHewan(),
          ],
        ),
      ),
    );
  }

  void _onChangedRadio(int value) {
    BlocProvider.of<JenisMakananBloc>(_scaffoldState.currentContext).add(value);
  }
}

class WidgetDropdownHewan extends StatefulWidget {
  @override
  _WidgetDropdownHewanState createState() => _WidgetDropdownHewanState();
}

class _WidgetDropdownHewanState extends State<WidgetDropdownHewan> {
  String hewanSelected = '-';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocListener<HewanBloc, List<String>>(
          listener: (context, state) {
            if (state != null && state.length > 0) {
              hewanSelected = state[0];
            }
          },
          child: BlocBuilder<HewanBloc, List<String>>(
            builder: (context, state) {
              return DropdownButton(
                items: state.map((namaHewan) {
                  return DropdownMenuItem(
                    child: Text(namaHewan),
                    value: namaHewan,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    hewanSelected = value;
                  });
                },
                value: hewanSelected,
              );
            },
          ),
        ),
      ],
    );
  }
}

// BLoC
class JenisMakananBloc extends Bloc<int, int> {
  @override
  int get initialState => -1;

  @override
  Stream<int> mapEventToState(int event) async* {
    yield event;
  }
}

class HewanBloc extends Bloc<int, List<String>> {
  @override
  List<String> get initialState => [];

  @override
  Stream<List<String>> mapEventToState(int event) async* {
    List<String> listHewan = [];
    Dio dio = Dio();
    if (event == 0) {
      var response = await dio.get('http://bengkelrobot.net:8001/karnivora');
      String strJsonResponse = json.encode(response.data);
      var jsonResponse = json.decode(strJsonResponse);
      listHewan.addAll(List<String>.from(jsonResponse.map((item) => item)));
      print('listHewan: $listHewan');
      yield listHewan;
    } else if (event == 1) {
      var response = await dio.get('http://bengkelrobot.net:8001/herbivora');
      String strJsonResponse = json.encode(response.data);
      var jsonResponse = json.decode(strJsonResponse);
      listHewan.addAll(List<String>.from(jsonResponse.map((item) => item)));
      print('listHewan: $listHewan');
      yield listHewan;
    } else if (event == 2) {
      var response = await dio.get('http://bengkelrobot.net:8001/omnivora');
      String strJsonResponse = json.encode(response.data);
      var jsonResponse = json.decode(strJsonResponse);
      listHewan.addAll(List<String>.from(jsonResponse.map((item) => item)));
      print('listHewan: $listHewan');
      yield listHewan;
    }
  }
}
