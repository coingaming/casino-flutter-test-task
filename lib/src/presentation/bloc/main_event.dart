import 'package:casino_test/src/data/models/character.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  const GetTestDataOnMainPageEvent({
    this.forceRefresh = false,
    this.isLoadingNextPage = false,
    this.filter,
  });

  final bool forceRefresh;
  final bool isLoadingNextPage;
  final String? filter;

  @override
  List<Object?> get props => [forceRefresh, isLoadingNextPage, filter];
}

class GetFilteredDataOnMainPageEvent extends MainPageEvent {
  const GetFilteredDataOnMainPageEvent({
    required this.filter,
    this.isLoadingNextPage = false,
    this.forceRefresh = false,
  });
  final String filter;
  final bool isLoadingNextPage;
  final bool forceRefresh;

  @override
  List<Object?> get props => [
        filter,
        isLoadingNextPage,
        forceRefresh,
      ];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  const DataLoadedOnMainPageEvent(this.characters,
      {this.isLoadingNextPage = false, this.filter});
  final List<Character>? characters;
  final bool isLoadingNextPage;
  final String? filter;

  @override
  List<Object?> get props => [characters, isLoadingNextPage, filter];
}

class GetNextPageOnMainPageEvent extends MainPageEvent {
  const GetNextPageOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class ErrorOnMainPageEvent extends MainPageEvent {
  const ErrorOnMainPageEvent({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
