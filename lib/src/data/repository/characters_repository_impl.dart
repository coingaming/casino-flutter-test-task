import 'dart:async';
import 'dart:convert';
import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:casino_test/src/data/models/wrapper_character/wrapper_character_model.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);
  String nextPageUrl = "";
  List<CharacterModel> characters = List.empty(growable: true);

  @override
  Future<List<CharacterModel>?> getCharacters(int page) async {
    characters.clear();

    final charResult = await client.get(
        Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"));

    final Map<String, dynamic> jsonMap =
        await json.decode(charResult.body) as Map<String, dynamic>;

    if (charResult.statusCode == 200) {
      if (charResult.body.isNotEmpty) {
        final wrapper = WrapperCharacterModel.fromJson(jsonMap);
        nextPageUrl = wrapper.info.next ?? "";
        characters.addAll(wrapper.results);
        return Future.value(characters);
      }
    }
    return Future.error("Failed to load data");
  }

  @override
  Future<List<CharacterModel>?> nextPage() async {
    if (nextPageUrl.isNotEmpty) {
      final charResult = await client.get(Uri.parse(nextPageUrl));

      if (charResult.statusCode == 200) {
        if (charResult.body.isNotEmpty) {
          final Map<String, dynamic> jsonMap =
              await json.decode(charResult.body) as Map<String, dynamic>;

          final wrapper = WrapperCharacterModel.fromJson(jsonMap);

          nextPageUrl = wrapper.info.next ?? "";
          characters.addAll(wrapper.results);

          return Future.value(characters);
        }
      }
    }
    return Future.value(null);
  }

  Future<List<CharacterModel>?> searchCharacter(String name) async {
    characters.clear();
    final charResult = await client.get(
        Uri.parse("https://rickandmortyapi.com/api/character/?name=$name"));

    if (charResult.statusCode == 200) {
      if (charResult.body.isNotEmpty) {
        final Map<String, dynamic> jsonMap =
            await json.decode(charResult.body) as Map<String, dynamic>;

        final wrapper = WrapperCharacterModel.fromJson(jsonMap);

        nextPageUrl = wrapper.info.next ?? "";
        characters.addAll(wrapper.results);

        return Future.value(characters);
      }
    } else
      return Future.value([]);
    return Future.value([]);
  }
}
