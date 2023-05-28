import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  final int page;

  const GetTestDataOnMainPageEvent(this.page);

  @override
  List<Object?> get props => [];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  final List<CharacterModel>? characters;

  const DataLoadedOnMainPageEvent(this.characters);

  @override
  List<Object?> get props => [characters];
}

class GetNextPageOnMainPageEvent extends MainPageEvent {
  final bool isFetching;
  const GetNextPageOnMainPageEvent(this.isFetching);

  @override
  List<Object?> get props => [];
}

class SearchCharacterOnMainPageEvent extends MainPageEvent {
  final String name;
  const SearchCharacterOnMainPageEvent(this.name);

  @override
  List<Object?> get props => [];
}

class ErrorMainPageEvent extends MainPageEvent {
  final String message;

  const ErrorMainPageEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class LostConnectionEvent extends MainPageEvent {
  final bool hasConnection;
  const LostConnectionEvent({required this.hasConnection});

  @override
  List<Object?> get props => [];
}
