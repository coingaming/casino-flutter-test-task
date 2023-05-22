import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/presentation/ui/characters_screen/characters_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() {
  MainDIModule().configure(GetIt.I);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: MaterialApp(
        theme: ThemeData.from(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.grey[800]!,
            primary: Colors.greenAccent[700],
            brightness: Brightness.dark,
          ),
          textTheme: Typography.blackCupertino,
        ),
        title: 'Test app',
        home: const CharactersListScreen(),
      ),
    );
  }
}
