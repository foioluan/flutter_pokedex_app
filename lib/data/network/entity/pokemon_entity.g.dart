// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonEntity _$PokemonEntityFromJson(Map<String, dynamic> json) =>
    PokemonEntity(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: Map<String, String>.from(json['name'] as Map),
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      base: Map<String, int>.from(json['base'] as Map),
    );

Map<String, dynamic> _$PokemonEntityToJson(PokemonEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'base': instance.base,
    };
