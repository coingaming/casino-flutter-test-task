import 'package:casino_test/src/data/models/character.dart';

typedef Result = ({Exception? error, List<Character> data});

abstract interface class CharactersRepository {
  Future<Result> getNextPage();
  Future<Result> getCharacters({String? query});
}
