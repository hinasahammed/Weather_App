import 'package:json_annotation/json_annotation.dart';

part 'clouds.g.dart';

@JsonSerializable()
class Clouds {
  int? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return _$CloudsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}
