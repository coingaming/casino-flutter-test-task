import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/character_model.dart';

typedef RequestResponse = ({CharacterModel? response, String? error});

abstract class CharactersRepository {
  Future<RequestResponse> getCharacters({String nextPageUrl});
}
