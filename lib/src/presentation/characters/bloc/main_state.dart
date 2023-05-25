import 'package:casino_test/src/data/models/character.dart';
import 'package:equatable/equatable.dart';

sealed class MainPageState extends Equatable {}

class InitialMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class LoadingMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class ErrorMainPageState extends MainPageState {
  final String error;
  ErrorMainPageState({required this.error});
  @override
  List<Object> get props => [error];
}

class UnSuccessfulMainPageState extends MainPageState {
  final String reason;
  UnSuccessfulMainPageState({required this.reason});
  @override
  List<Object> get props => [reason];
}

class SuccessfulMainPageState extends MainPageState {
  final List<Character> characters;
  final bool loadingMoreData;
  final String error;
  final String nextPageUrl;
  SuccessfulMainPageState(
      {required this.characters,
      this.loadingMoreData = false,
      this.nextPageUrl = '',
      this.error = ''});
  SuccessfulMainPageState copyWith(
          {List<Character>? characters,
          bool? loadingMoreData,
          String? error,
          String? nextPageUrl}) =>
      SuccessfulMainPageState(
          characters: characters ?? this.characters,
          loadingMoreData: loadingMoreData ?? this.loadingMoreData,
          error: error ?? this.error,
          nextPageUrl: nextPageUrl ?? this.nextPageUrl);
  @override
  List<Object> get props => [characters, loadingMoreData, error, nextPageUrl];
  @override
  bool? get stringify => true;
}
