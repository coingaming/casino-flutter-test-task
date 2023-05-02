import 'package:flutter/material.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/bloc/main_bloc.dart';
import 'package:casino_test/src/bloc/main_event.dart';
import 'package:casino_test/src/presentation/screens/character_screen.dart';
import 'package:casino_test/src/utils/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MainDIModule().configure(GetIt.I);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: currentTheme.currentTheme,
            title: 'Test app',
            home: child,
          );
        },
        child: BlocProvider<MainPageBloc>(
            create: (context) => MainPageBloc(
                  GetIt.I.get<CharactersRepository>(),
                )..add(const GetTestDataOnMainPageEvent()),
            child: CharactersScreen()));
  }
}
