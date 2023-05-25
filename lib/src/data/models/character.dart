import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final String url;
  final String created;

  Character(
      {required this.name,
      required this.image,
      required this.created,
      required this.status,
      required this.url,
      required this.gender,
      required this.id,
      required this.species});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
