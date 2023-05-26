import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:equatable/equatable.dart';

enum MainPageAlert { empty, error }

abstract class MainPageState extends Equatable {
  final bool isFetching;
  final MainPageAlert? alert;
  MainPageState({this.alert, this.isFetching = false});

  @override
  List<Object?> get props => [
        isFetching,
      ];
}

class InitialMainPageState extends MainPageState {
  InitialMainPageState();

  @override
  List<Object> get props => [];
}

class LoadingMainPageState extends MainPageState {
  LoadingMainPageState();

  @override
  List<Object> get props => [isFetching];
}

class LostConnectionState extends MainPageState {
  final bool hasConnection;
  LostConnectionState(this.hasConnection);

  @override
  List<Object> get props => [isFetching];
}

class UnSuccessfulMainPageState extends MainPageState {
  UnSuccessfulMainPageState();

  @override
  List<Object> get props => [];
}

class SuccessfulMainPageState extends MainPageState {
  final bool? hasConnection;
  final List<CharacterModel> characters;
  SuccessfulMainPageState(this.characters,
      {this.hasConnection, super.isFetching, super.alert});

  @override
  List<Object?> get props => [characters, isFetching, alert];
}

class ErrorMainPageState extends MainPageState {
  final String message;

  ErrorMainPageState(this.message);

  @override
  List<Object> get props => [message];
}
