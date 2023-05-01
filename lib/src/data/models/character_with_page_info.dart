import 'package:json_annotation/json_annotation.dart';

import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/page_info.dart';

part 'character_with_page_info.g.dart';

@JsonSerializable()
class CharactersWithPageInfo {
  final List<Character> results;
  final PageInfo info;

  CharactersWithPageInfo(this.results, this.info);

  factory CharactersWithPageInfo.fromJson(Map<String, dynamic> json) =>
      _$CharactersWithPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersWithPageInfoToJson(this);
}
