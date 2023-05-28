import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wrapper_character_model.g.dart';

@JsonSerializable()
class WrapperCharacterModel {
  final InfoModel info;
  final List<CharacterModel> results;

  const WrapperCharacterModel({
    required this.info,
    required this.results,
  });

  factory WrapperCharacterModel.fromJson(Map<String, dynamic> json) =>
      _$WrapperCharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$WrapperCharacterModelToJson(this);
}
