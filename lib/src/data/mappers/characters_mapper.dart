// ignore_for_file: library_private_types_in_public_api

import 'package:casino_test/src/data/models/character.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'characters_mapper.g.dart';

@JsonSerializable()
final class CharactersMapper extends Equatable {
  final _Info info;
  final List<Character> results;

  const CharactersMapper({
    required this.info,
    required this.results,
  });

  @override
  List<Object?> get props => [info, results];

  factory CharactersMapper.fromJson(Map<String, dynamic> json) => _$CharactersMapperFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersMapperToJson(this);
}

@JsonSerializable()
class _Info {
  _Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  factory _Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
