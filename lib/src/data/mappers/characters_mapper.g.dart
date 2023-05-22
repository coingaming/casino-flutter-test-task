// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_mapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersMapper _$CharactersMapperFromJson(Map<String, dynamic> json) =>
    CharactersMapper(
      info: _Info.fromJson(json['info'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharactersMapperToJson(CharactersMapper instance) =>
    <String, dynamic>{
      'info': instance.info,
      'results': instance.results,
    };

_Info _$InfoFromJson(Map<String, dynamic> json) => _Info(
      count: json['count'] as int,
      pages: json['pages'] as int,
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );

Map<String, dynamic> _$InfoToJson(_Info instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
