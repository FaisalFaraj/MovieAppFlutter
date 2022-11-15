// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as String?,
      title: json['title'] as String?,
      img: json['img'] as String?,
      thumb: json['thumb'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      release_date: json['release_date'] == null
          ? null
          : DateTime.parse(json['release_date'] as String),
      is_disabled: json['is_disabled'] as bool?,
      running_time: json['running_time'] == null
          ? null
          : RunningTime.fromJson(json['running_time'] as Map<String, dynamic>),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      description: json['description'] as String?,
      rental_rate: json['rental_rate'] as int?,
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => Actor.fromJson(e as Map<String, dynamic>))
          .toList(),
      avg_rate: json['avg_rate'] as int?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'img': instance.img,
      'thumb': instance.thumb,
      'release_date': instance.release_date?.toIso8601String(),
      'is_disabled': instance.is_disabled,
      'running_time': instance.running_time,
      'created_at': instance.created_at?.toIso8601String(),
      'description': instance.description,
      'rental_rate': instance.rental_rate,
      'cast': instance.cast,
      'genres': instance.genres,
      'avg_rate': instance.avg_rate,
    };
