// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      json['name'] as String,
      json['image'] as String,
      json['status'] as String,
      json['gender'] as String,
      json['species'] as String,
      json['type'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'gender': instance.gender,
      'species': instance.species,
      'type': instance.type,
    };
