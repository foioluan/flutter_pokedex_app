import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  factory Pokemon({
    required int id,
    required Map<String, String> name,
    required List<String> type,
    required Map<String, int> base,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}