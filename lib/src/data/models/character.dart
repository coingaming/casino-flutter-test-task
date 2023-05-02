import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character extends Equatable {
  final String name;
  final String image;
  final String status;
  final String gender;
  final String species;
  final String type;

  Character(
      this.name, this.image, this.status, this.gender, this.species, this.type);

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  List<Map<String, String>> toList() {
    return [
      {
        'name': this.name,
      },
      {
        'status': this.status,
      },
      {
        'gender': this.gender,
      },
      {
        'species': this.species,
      },
      {'type': this.type}
    ];
  }

  @override
  List<Object?> get props => [name, image, status, gender, species, type];
}
