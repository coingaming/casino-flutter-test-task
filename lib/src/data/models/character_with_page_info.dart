import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/models/page_info.dart';

part 'character_with_page_info.g.dart';

@JsonSerializable()
class CharactersWithPageInfo extends Equatable {
  final List<Character> results;
  final PageInfo info;

  CharactersWithPageInfo(this.results, this.info);

  factory CharactersWithPageInfo.fromJson(Map<String, dynamic> json) =>
      _$CharactersWithPageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersWithPageInfoToJson(this);

  @override
  List<Object?> get props => [results, info];
}
