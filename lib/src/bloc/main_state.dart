import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/services/app_exceptions.dart';
import 'package:equatable/equatable.dart';

enum MainPageStatus { initial, success, error, loading }

extension MainPageStatusX on MainPageStatus {
  bool get isInitial => this == MainPageStatus.initial;
  bool get isSuccess => this == MainPageStatus.success;
  bool get isError => this == MainPageStatus.error;
  bool get isLoading => this == MainPageStatus.loading;
}

class MainPageState extends Equatable {
  const MainPageState({
    this.status = MainPageStatus.initial,
    this.characters = const <Character>[],
    this.hasReachedMax = false,
    this.currentPage = 0,
    this.errorMessage,
  });

  final MainPageStatus status;
  final List<Character> characters;
  final bool hasReachedMax;
  final int currentPage;
  final AppException? errorMessage;

  MainPageState copyWith(
      {MainPageStatus? status,
      List<Character>? characters,
      bool? hasReachedMax,
      int? currentPage,
      AppException? errorMessage}) {
    return MainPageState(
        characters: characters ?? this.characters,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object> get props => [status, characters, hasReachedMax, currentPage];
}
