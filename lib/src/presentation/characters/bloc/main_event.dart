import 'package:casino_test/src/data/models/character_model.dart';
import 'package:equatable/equatable.dart';

sealed class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  const GetTestDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class AddMoreDataOnMainPageEvent extends MainPageEvent {
  final String nextPageUrl;

  const AddMoreDataOnMainPageEvent(this.nextPageUrl);

  @override
  List<Object?> get props => [nextPageUrl];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  final CharacterModel? model;

  const DataLoadedOnMainPageEvent(this.model);

  @override
  List<Object?> get props => [model];
}
