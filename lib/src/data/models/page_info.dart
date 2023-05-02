import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_info.g.dart';

@JsonSerializable()
class PageInfo extends Equatable {
  final int count;
  final int pages;

  PageInfo(this.count, this.pages);

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
  
  @override
  List<Object?> get props => [count, pages];
}
