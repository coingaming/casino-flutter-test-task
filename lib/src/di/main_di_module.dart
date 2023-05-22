import 'package:casino_test/src/data/repositories/characters_repository.dart';
import 'package:casino_test/src/data/repositories/characters_repository_impl.dart';
import 'package:casino_test/src/data/services/connectivity_service.dart';
import 'package:casino_test/src/data/services/connectivity_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MainDIModule {
  void configure(GetIt getIt) {
    final httpClient = Client();
    final connectivityInstance = InternetConnectionChecker.createInstance(
      checkInterval: const Duration(seconds: 2),
    );

    getIt.registerLazySingleton<CharactersRepository>(
      () => CharactersRepositoryImpl(httpClient),
    );
    getIt.registerLazySingleton<ConnectivityService>(
      () => ConnectivityServiceImpl(connectivityInstance),
    );
  }
}
