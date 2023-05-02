import 'package:casino_test/src/bloc/main_bloc.dart';
import 'package:casino_test/src/bloc/main_event.dart';
import 'package:casino_test/src/bloc/main_state.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/character_with_page_info.dart';
import 'package:casino_test/src/data/repository/characters_repository_impl.dart';
import 'package:casino_test/src/data/services/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockCharacterRepository extends Mock
    implements CharactersRepositoryImpl {}



void main() {
  group('MainPageBloc', () {
    late MainPageBloc mainPageBloc;
    late MockCharacterRepository mockCharacterRepository;
    MainPageState mainPageState = MainPageState();

    setUp(() {
      mockCharacterRepository = MockCharacterRepository();
      final Map<String, dynamic> json = {
        'results': [
          {
            "name": "Toxic Rick",
            "status": "Dead",
            "species": "Humanoid",
            "type": "Rick's Toxic Side",
            "gender": "Male",
            "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg"
          }
        ],
        'info': {'pages': 42, 'count': 826}
      };

      final CharactersWithPageInfo characterWithPageInfo =
          CharactersWithPageInfo.fromJson(json);

      when(() => mockCharacterRepository.getCharacters(1))
          .thenAnswer((_) async => right(characterWithPageInfo));

      mainPageBloc = MainPageBloc(mockCharacterRepository);
    });

    final characterJson = {
      "name": "Toxic Rick",
      "status": "Dead",
      "species": "Humanoid",
      "type": "Rick's Toxic Side",
      "gender": "Male",
      "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg"
    };

    test(
        'expect the mainPageState to be {state: MainPageState.initial, character: [], hasReachedMax: false, currentPage: 0}, ',
        () {
      expect(
          mainPageBloc.state,
          mainPageState.copyWith(
              status: MainPageStatus.initial,
              characters: [],
              hasReachedMax: false,
              currentPage: 0));
    });

    blocTest<MainPageBloc, MainPageState>(
        'expect the mainPageState to trasition from loading to success',
        build: () => mainPageBloc,
        act: (bloc) => mainPageBloc.add(GetTestDataOnMainPageEvent()),
        expect: () => [
              mainPageState.copyWith(
                  status: MainPageStatus.loading,
                  characters: [],
                  hasReachedMax: false,
                  currentPage: 0),
              mainPageState.copyWith(
                  status: MainPageStatus.success,
                  characters: [Character.fromJson(characterJson)],
                  hasReachedMax: false,
                  currentPage: 1)
            ]);

    blocTest<MainPageBloc, MainPageState>(
      'mainPageState should change from loading to error when error is thrown',
      build: () {
        when(() => mockCharacterRepository.getCharacters(1)).thenAnswer(
            (_) async => left(NoInternetException('No Internet available')));

        mainPageBloc = MainPageBloc(mockCharacterRepository);

        return mainPageBloc;
      },
      act: (bloc) => mainPageBloc.add(GetTestDataOnMainPageEvent()),
      expect: () => [
        mainPageState.copyWith(
            status: MainPageStatus.loading,
            characters: [],
            hasReachedMax: false,
            currentPage: 0),
        mainPageState.copyWith(
            status: MainPageStatus.error,
            characters: [],
            hasReachedMax: false,
            currentPage: 0,
            errorMessage: AppException('No Internet available', 'No Internet'))
      ],
    );

    tearDown(() {
      mainPageBloc.close();
    });
  });
}
