import 'package:casino_test/src/data/models/character_with_page_info.dart';
import 'package:casino_test/src/data/services/app_exceptions.dart';
import 'package:dartz/dartz.dart';


abstract class CharactersRepository {
  Future<Either<AppException?, CharactersWithPageInfo>> getCharacters(int page);
}
