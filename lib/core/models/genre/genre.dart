import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'created_at')
  DateTime? created_at;
  @JsonKey(name: 'updated_at')
  DateTime? updated_at;

  Genre({this.id, this.name, this.created_at, this.updated_at});

  /// Connect the generated [_$GenreFromJson] function to the `fromJson`
  /// factory.
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
