import 'package:json_annotation/json_annotation.dart';
part 'info.g.dart';

@JsonSerializable()
class InfoModel {
  InfoModel({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  final int count;
  final int pages;
  final String? next;
  final String? prev;

  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}
