import 'package:json_annotation/json_annotation.dart';

import '../actor/actor.dart';
import '../running_time/running_time.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'id')
  String? id; // uuid
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'img')
  String? img;
  @JsonKey(name: 'thumb')
  String? thumb;
  @JsonKey(name: 'release_date')
  DateTime? release_date;
  @JsonKey(name: 'is_disabled')
  bool? is_disabled;
  @JsonKey(name: 'running_time')
  RunningTime? running_time;
  @JsonKey(name: 'created_at')
  DateTime? created_at;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'rental_rate')
  int? rental_rate;
  @JsonKey(name: 'cast')
  List<Actor>? cast;
  @JsonKey(name: 'genres')
  List<Map>? genres;
  @JsonKey(name: 'avg_rate')
  int? avg_rate;

  Movie({
    this.id,
    this.title,
    this.img,
    this.thumb,
    this.genres,
    this.release_date,
    this.is_disabled,
    this.running_time,
    this.created_at,
    this.description,
    this.rental_rate,
    this.cast,
    this.avg_rate,
  });

  /// Connect the generated [_$MovieFromJson] function to the `fromJson`
  /// factory.
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
// An example movie model that should be serialized.
//   -  : means that its ok if the value is null
//   - @BuiltValueField: is the key that is in the JSON you
//     receive from an API
//

