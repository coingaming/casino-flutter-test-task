import 'package:casino_test/src/data/models/character/character_model.dart';

abstract class CharactersRepository {
  Future<List<CharacterModel>?> getCharacters(int page);
  Future<List<CharacterModel>?> nextPage();
  Future<List<CharacterModel>?> searchCharacter(String name);
}
