import 'package:json_annotation/json_annotation.dart';

part 'info_model.g.dart';

@JsonSerializable()
class InfoModel {
  int count;
  int pages;
  String next;
  String prev;

  InfoModel(
      {required this.count,
      required this.pages,
      required this.next,
      required this.prev});
  factory InfoModel.fromJson(Map<String, dynamic> json) =>
      _$InfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$InfoModelToJson(this);
}
