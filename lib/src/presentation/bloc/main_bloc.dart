import 'package:casino_test/src/data/repositories/characters_repository.dart';
import 'package:casino_test/src/data/repositories/characters_repository_impl.dart';
import 'package:casino_test/src/data/services/connectivity_service.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(const InitialMainPageState()) {
    _connectivityService.statusStream.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        add(const ErrorOnMainPageEvent(error: 'You are offline'));
      } else if (status == InternetConnectionStatus.connected) {
        add(const GetTestDataOnMainPageEvent(forceRefresh: true));
      }
    });

    on<GetTestDataOnMainPageEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<GetFilteredDataOnMainPageEvent>(
      (event, emitter) => _getFilteredDataOnMainPageCasino(event, emitter),
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) => emitter(const LoadingMainPageState()),
    );

    on<GetNextPageOnMainPageEvent>(
      (event, emitter) => _fetchNextPage(event, emitter),
    );
    on<ErrorOnMainPageEvent>(
      (event, emitter) => emitter(UnSuccessfulMainPageState(error: event.error)),
    );
  }

  final CharactersRepository _charactersRepository = GetIt.I.get<CharactersRepository>();
  final ConnectivityService _connectivityService = GetIt.I.get<ConnectivityService>();

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (event.characters != null) {
      emit(SuccessfulMainPageState(
        characters: event.characters!,
        filter: event.filter,
      ));
    } else {
      emit(const UnSuccessfulMainPageState(error: 'Error fetching data'));
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (!event.isLoadingNextPage) {
      add(const LoadingDataOnMainPageEvent());
    }

    _charactersRepository
        .getCharacters(query: event.filter)
        .then((value) => _handleCommonErrors(emit, state, value));
  }

  Future<void> _fetchNextPage(GetNextPageOnMainPageEvent event, Emitter<MainPageState> emit) async {
    _charactersRepository.getNextPage().then((value) => _handleCommonErrors(emit, state, value));
  }

  Future<void> _getFilteredDataOnMainPageCasino(
    GetFilteredDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (!event.isLoadingNextPage) {
      add(const LoadingDataOnMainPageEvent());
    }

    _charactersRepository
        .getCharacters(query: event.filter)
        .then((value) => _handleCommonErrors(emit, state, value));
  }

  void _handleCommonErrors(Emitter<MainPageState> emit, MainPageState state, Result result) {
    return switch (result.error) {
      null => add(DataLoadedOnMainPageEvent(result.data)),
      ServerExceptionError() => add(const ErrorOnMainPageEvent(error: 'Server error')),
      NoNextPageException() => () {
          if (state is SuccessfulMainPageState) {
            emit(state.copyWith(hasNextPage: false));
          }
        }.call(),
      _ => add(const ErrorOnMainPageEvent(error: 'Unknown error. Are you offline?')),
    };
  }

  @override
  Future<void> close() {
    _connectivityService.dispose();
    return super.close();
  }
}
