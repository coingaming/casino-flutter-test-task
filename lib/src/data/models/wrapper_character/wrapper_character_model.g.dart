// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrapper_character_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WrapperCharacterModel _$WrapperCharacterModelFromJson(
        Map<String, dynamic> json) =>
    WrapperCharacterModel(
      info: InfoModel.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WrapperCharacterModelToJson(
        WrapperCharacterModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };
