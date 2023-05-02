import 'dart:async';

import 'package:casino_test/src/constants.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/data/services/app_exceptions.dart';
import 'package:casino_test/src/data/services/base_client.dart';
import 'package:dartz/dartz.dart';

import '../models/character_with_page_info.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final DataClient dataClient;

  CharactersRepositoryImpl(this.dataClient);

  @override
  Future<Either<AppException?, CharactersWithPageInfo>> getCharacters(
      int page) async {
    try {
      final results = await dataClient.get('${Endpoints.character}$page');
      return right(CharactersWithPageInfo.fromJson(results));
    } on AppException catch (e) {
      return left(e);
    }
  }
}
