import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:casino_test/src/data/services/base_client.dart';
import 'package:casino_test/src/data/services/base_client_impl.dart';
import 'package:casino_test/src/utils/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MainDIModule {
  void configure(GetIt getIt) {
    final httpClient = Client();

    // Network info
    getIt.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(connectionChecker: getIt()));

    // data provider client
    getIt.registerLazySingleton<DataClient>(
        () => DataClientImp(client: httpClient, networkInfo: getIt()));

    // Character repository
    getIt.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(getIt()));

    getIt.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());
  }
}
