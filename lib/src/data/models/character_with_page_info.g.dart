// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_with_page_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersWithPageInfo _$CharactersWithPageInfoFromJson(
        Map<String, dynamic> json) =>
    CharactersWithPageInfo(
      (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
      PageInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharactersWithPageInfoToJson(
        CharactersWithPageInfo instance) =>
    <String, dynamic>{
      'results': instance.results,
      'info': instance.info,
    };
