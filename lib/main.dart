import 'dart:async';
import 'dart:developer';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final internetConnectionChecker = InternetConnectionChecker.createInstance(
  checkTimeout: const Duration(seconds: 5),
  checkInterval: const Duration(seconds: 3),
);

class ConnectionNotfier extends InheritedNotifier<ValueNotifier<bool>> {
  ConnectionNotfier({super.key, required super.notifier, required super.child});

  static ValueNotifier<bool> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ConnectionNotfier>()!
        .notifier!;
  }
}

void main() async {
  Bloc.observer = BeerBlocObserver();
  final hasConnection = await internetConnectionChecker.hasConnection;
  _setupLocator();
  runApp(ConnectionNotfier(
      notifier: ValueNotifier(hasConnection),
      child: MyApp(hasConnection: hasConnection)));
}

void _setupLocator() {
  MainDIModule.init(GetIt.I);
}

class MyApp extends StatefulWidget {
  final bool hasConnection;
  const MyApp({required this.hasConnection, Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _mainBloc =
      MainPageBloc(InitialMainPageState(), GetIt.I.get<CharactersRepository>());
  late final StreamSubscription<InternetConnectionStatus> lister;
  @override
  void initState() {
    super.initState();
    lister = internetConnectionChecker.onStatusChange.listen((status) {
      final notifier = ConnectionNotfier.of(context);
      notifier.value =
          status == InternetConnectionStatus.connected ? true : false;
    });
  }

  @override
  void dispose() {
    lister.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasConnection = ConnectionNotfier.of(context).value;
    _mainBloc.add(LostConnectionEvent(hasConnection: hasConnection));
    if (hasConnection) _mainBloc.add(GetTestDataOnMainPageEvent(1));

    return MaterialApp(
        title: 'Test app',
        home: BlocProvider.value(
          value: _mainBloc,
          child: CharactersScreen(
            hasConnection: hasConnection,
          ),
        ));
  }
}

class BeerBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log("currentState: ${change.currentState.runtimeType} nextState: ${change.nextState.runtimeType}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(event.runtimeType.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}
