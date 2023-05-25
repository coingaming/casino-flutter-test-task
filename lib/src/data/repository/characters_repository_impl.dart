import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:casino_test/src/data/models/character_model.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;
  CharactersRepositoryImpl(this.client);

  @override
  Future<RequestResponse> getCharacters({String? nextPageUrl}) async {
    try {
      String url = switch (nextPageUrl) {
        (String url) => url,
        _ => "https://rickandmortyapi.com/api/character",
      };

      var client = Client();
      final result = await client.get(
        Uri.parse(url),
      );

      if (result.statusCode == 200) {
        final jsonMap = await json.decode(result.body);

        final bool showMockedError = Random().nextBool();
        print("casino test log: showMockedError = $showMockedError");
        if (showMockedError) {
          return Future.delayed(
            const Duration(seconds: 5),
            () => (response: null, error: 'A Mocked Error just occurred'),
          );
        }
        return Future.value(
            (response: CharacterModel.fromJson(jsonMap), error: null));
      } else {
        return (response: null, error: 'An error occurred ');
      }
    } on SocketException {
      return (
        response: null,
        error: "Please check your internet connectivity and try again"
      );
    } catch (e) {
      return (response: null, error: e.toString());
    }
  }
}
