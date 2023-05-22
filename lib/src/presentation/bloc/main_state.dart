import 'package:casino_test/src/data/models/character.dart';
import 'package:equatable/equatable.dart';

sealed class MainPageState extends Equatable {}

final class InitialMainPageState implements MainPageState {
  const InitialMainPageState();

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class LoadingMainPageState implements MainPageState {
  const LoadingMainPageState();

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class UnSuccessfulMainPageState implements MainPageState {
  const UnSuccessfulMainPageState({required this.error});

  final String error;

  @override
  List<Object> get props => [error];

  @override
  bool? get stringify => false;
}

class SuccessfulMainPageState implements MainPageState {
  const SuccessfulMainPageState(
      {required this.characters,
      this.isLoadingNextPage = false,
      this.filter,
      this.hasNextPage = true});
  final String? filter;
  final List<Character> characters;
  final bool isLoadingNextPage;
  final bool hasNextPage;

  SuccessfulMainPageState copyWith(
          {List<Character>? characters,
          bool? isLoadingNextPage,
          String? filter,
          bool? hasNextPage}) =>
      SuccessfulMainPageState(
        characters: characters ?? this.characters,
        isLoadingNextPage: isLoadingNextPage ?? this.isLoadingNextPage,
        filter: filter ?? this.filter,
        hasNextPage: hasNextPage ?? this.hasNextPage,
      );

  @override
  List<Object?> get props => [characters, isLoadingNextPage, filter, hasNextPage];

  @override
  bool? get stringify => true;
}
