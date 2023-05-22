import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() async {
  group(
    'MainPageBloc test',
    () {
      late MainPageBloc mainPageBloc;

      setUpAll(() {
        MainDIModule().configure(GetIt.I);
        mainPageBloc = MainPageBloc();
      });

      tearDownAll(() {
        mainPageBloc.close();
      });

      test('Test if initial state is correct', () {
        expect(mainPageBloc.state, const InitialMainPageState());
      });

      test(
        'expects the state to change from Loading to Successful when the data is successfully fetched',
        () {
          mainPageBloc.add(const GetTestDataOnMainPageEvent());
          final expected = [
            isA<LoadingMainPageState>(),
            isA<SuccessfulMainPageState>()
                .having((state) => state.characters, 'characters', hasLength((20))),
          ];
          expectLater(mainPageBloc.stream, emitsInOrder(expected));
        },
      );

      test(
        'expects that the state change from Loading to UnSuccessful when the requested data cannot be fetched',
        () {
          mainPageBloc.add(const GetTestDataOnMainPageEvent(
              filter: 'INVALID_CHARACTER_NAME', forceRefresh: true));
          final expected = [
            isA<LoadingMainPageState>(),
            isA<UnSuccessfulMainPageState>(),
          ];
          expectLater(mainPageBloc.stream, emitsInOrder(expected));
        },
      );
    },
  );
}
