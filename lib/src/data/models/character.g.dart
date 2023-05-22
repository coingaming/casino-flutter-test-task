// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: _Origin.fromJson(json['origin'] as Map<String, dynamic>),
      location: _Location.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
      episode:
          (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
      url: json['url'] as String,
      created: json['created'] as String,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
      'episode': instance.episode,
      'url': instance.url,
      'created': instance.created,
    };

_Origin _$OriginFromJson(Map<String, dynamic> json) => _Origin(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$OriginToJson(_Origin instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };

_Location _$LocationFromJson(Map<String, dynamic> json) => _Location(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$LocationToJson(_Location instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
