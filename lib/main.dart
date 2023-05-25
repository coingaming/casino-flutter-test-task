import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/presentation/characters/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  MainDIModule().configure(GetIt.I);
  //Bloc.observer = CasinoTestBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app',
      home: CharactersScreen(),
    );
  }
}
