import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;
  List<CharacterModel> _characters = List.empty(growable: true);

  MainPageBloc(
    MainPageState initialState,
    this._charactersRepository,
  ) : super(initialState) {
    on<GetTestDataOnMainPageEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
    );
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) => emitter(LoadingMainPageState()),
    );
    on<GetNextPageOnMainPageEvent>(
      (event, emitter) => _getNextPageOnMainPageCasino(event, emitter),
    );
    on<SearchCharacterOnMainPageEvent>(
      (event, emitter) => _searchCharacterOnMainPageCasino(event, emitter),
    );
    on<ErrorMainPageEvent>(
      (event, emitter) => _handleError(event.message, emitter),
    );
  }

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (event.characters != null) {
      emit(SuccessfulMainPageState(event.characters!, isFetching: false));
    } else {
      emit(UnSuccessfulMainPageState());
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    add(LoadingDataOnMainPageEvent());
    await _charactersRepository.getCharacters(event.page).then((value) {
      _characters.addAll(value!);
      add(DataLoadedOnMainPageEvent(value));
    }, onError: (_) {
      add(ErrorMainPageEvent("Error loading data"));
    });
  }

  Future<void> _getNextPageOnMainPageCasino(
    GetNextPageOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(SuccessfulMainPageState(_characters, isFetching: true));
    await _charactersRepository.nextPage().then((value) {
      if (value == null || value.isEmpty) {
        emit(SuccessfulMainPageState(_characters,
            isFetching: false, alert: MainPageAlert.empty));
        return;
      }

      _characters.clear();
      _characters.addAll(value);
      emit(SuccessfulMainPageState(_characters, isFetching: false));
    }, onError: (_) {
      add(ErrorMainPageEvent("Error loading data"));
      return;
    });
  }

  Future<void> _searchCharacterOnMainPageCasino(
    SearchCharacterOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    add(LoadingDataOnMainPageEvent());

    await _charactersRepository.searchCharacter(event.name).then((value) {
      if (value == null || value.isEmpty || value.length == 0) {
        emit(ErrorMainPageState("No results found"));
        return;
      }

      _characters.clear();
      _characters.addAll(value);
      emit(SuccessfulMainPageState(_characters, isFetching: false));
    });
  }

  _handleError(String error, Emitter<MainPageState> emit) {
    emit(ErrorMainPageState(error));
  }
}
