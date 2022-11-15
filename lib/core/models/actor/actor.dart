import 'package:json_annotation/json_annotation.dart';

part 'actor.g.dart';

@JsonSerializable()
class Actor {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'img')
  String? img;
  @JsonKey(name: 'thumb')
  String? thumb;
  @JsonKey(name: 'created_at')
  DateTime? created_at;
  @JsonKey(name: 'updated_at')
  DateTime? updated_at;

  Actor({this.id, this.name, this.created_at, this.updated_at});

  /// Connect the generated [_$ActorFromJson] function to the `fromJson`
  /// factory.
  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);
  Map<String, dynamic> toJson() => _$ActorToJson(this);
}
