import 'package:json_annotation/json_annotation.dart';

part 'running_time.g.dart';

@JsonSerializable()
class RunningTime {
  @JsonKey(name: 'hours')
  int? hours;
  @JsonKey(name: 'minutes')
  int? minutes;
  RunningTime({
    this.hours,
    this.minutes,
  });

  /// Connect the generated [_$RunningTimeFromJson] function to the `fromJson`
  /// factory.
  factory RunningTime.fromJson(Map<String, dynamic> json) =>
      _$RunningTimeFromJson(json);
  Map<String, dynamic> toJson() => _$RunningTimeToJson(this);
}
