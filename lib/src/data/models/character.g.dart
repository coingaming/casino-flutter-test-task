// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      image: json['image'] as String,
      created: json['created'] as String,
      status: json['status'] as String,
      url: json['url'] as String,
      gender: json['gender'] as String,
      id: json['id'] as int,
      species: json['species'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'gender': instance.gender,
      'image': instance.image,
      'url': instance.url,
      'created': instance.created,
    };
