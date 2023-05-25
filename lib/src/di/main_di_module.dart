import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class MainDIModule {
  MainDIModule._internal();

  void _configure(GetIt getIt) {
    final httpClient = Client();

    getIt.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(httpClient));
  }

  static MainDIModule get instance => _instance;

  static bool _hasInit = false;

  static Future<void> init(GetIt getIt) async {
    if (!_hasInit) {
      _hasInit = true;
      _instance._configure(getIt);
    }
  }

  static final MainDIModule _instance = MainDIModule._internal();
}
