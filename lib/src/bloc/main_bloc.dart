import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:casino_test/src/data/models/character_with_page_info.dart';
import 'package:dartz/dartz.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/bloc/main_event.dart';
import 'package:casino_test/src/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/services/app_exceptions.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;

  MainPageBloc(
    this._charactersRepository,
  ) : super(MainPageState()) {
    on<GetTestDataOnMainPageEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
      transformer: throttleDroppable(throttleDuration),
    );

  }

 

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    await _fetchAndEmit(emit);
  }

  Future<void> _fetchAndEmit(Emitter<MainPageState> emit) async {
    emit(state.copyWith(status: MainPageStatus.loading));

    if (state.hasReachedMax) {
      emit(state.copyWith(status: MainPageStatus.success));
      return;
    }

    int page = state.currentPage + 1;

    Either<AppException?, CharactersWithPageInfo>
        getEithercharactersWithPageInfo =
        await _charactersRepository.getCharacters(page);

    MainPageState _state = getEithercharactersWithPageInfo.fold((appException) {
      print(appException?.message);
      return state.copyWith(
          status: MainPageStatus.error, errorMessage: appException);
    }, (characterListWithPageInfo) {
      return state.copyWith(
          status: MainPageStatus.success,
          characters: state.status.isInitial
              ? characterListWithPageInfo.results
              : List.of(state.characters)
            ..addAll(characterListWithPageInfo.results),
          currentPage: page,
          hasReachedMax: page >= characterListWithPageInfo.info.pages);
    });

    emit(_state);
  }
}
