// ignore_for_file: library_private_types_in_public_api

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final _Origin origin;
  final _Location location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  @override
  List<Object?> get props => [id, name, created];

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

@JsonSerializable()
class _Origin extends Equatable {
  final String name;
  final String url;
  const _Origin({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];

  factory _Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);

  Map<String, dynamic> toJson() => _$OriginToJson(this);
}

@JsonSerializable()
class _Location extends Equatable {
  final String name;
  final String url;
  const _Location({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];

  factory _Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
