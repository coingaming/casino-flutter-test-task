import 'dart:async';
import 'dart:convert';

import 'package:casino_test/src/data/mappers/characters_mapper.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repositories/characters_repository.dart';
import 'package:http/http.dart';

final class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl(Client client) : _client = client;

  final Client _client;
  final List<Character> _characters = [];

  String? _nextPageUrl;

  @override
  Future<Result> getCharacters({String? query}) async {
    _characters.clear();

    try {
      final queryStr = query == null ? '' : '?name=$query';
      final response = await _client.get(
        Uri.parse('https://rickandmortyapi.com/api/character/$queryStr'),
      );

      if (response.statusCode == 200) {
        final mapper = CharactersMapper.fromJson(jsonDecode(response.body));

        if (mapper.results.isEmpty) throw NoCharactersFoundException();

        _nextPageUrl = mapper.info.next;
        _characters.addAll(mapper.results);
        return (data: _characters, error: null);
      }

      return (data: <Character>[], error: ServerExceptionError());
    } catch (e) {
      return (data: <Character>[], error: Exception(e.toString()));
    }
  }

  //  Future<List<Character>?> getCharactersByFilter2()

  @override
  Future<Result> getNextPage() async {
    try {
      if (_nextPageUrl == null) return (data: _characters, error: NoNextPageException());

      final response = await _client.get(Uri.parse(_nextPageUrl!));

      if (response.statusCode == 200) {
        final mapper = CharactersMapper.fromJson(jsonDecode(response.body));
        _nextPageUrl = mapper.info.next;
        _characters.addAll(mapper.results);
        return (data: _characters, error: null);
      }
      return (data: <Character>[], error: ServerExceptionError());
    } catch (e) {
      return (data: <Character>[], error: Exception(e.toString()));
    }
  }
}

class NoNextPageException implements Exception {}

class NoCharactersFoundException implements Exception {}

class ServerExceptionError implements Exception {}
