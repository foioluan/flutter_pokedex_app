import 'dart:convert';
import 'package:floor/floor.dart';

@Entity(tableName: 'Pokemon')
class PokemonDatabaseEntity {
  @primaryKey
  final int id;
  final String name;
  final String type;
  final String base;

  PokemonDatabaseEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
  });

  Map<String, String> getNameMap() => Map<String, String>.from(jsonDecode(name));

  List<String> getTypeList() => List<String>.from(jsonDecode(type));

  Map<String, int> getBaseMap() => Map<String, int>.from(jsonDecode(base));

  static String nameToJson(Map<String, String> nameMap) => jsonEncode(nameMap);

  static String typeToJson(List<String> typeList) => jsonEncode(typeList);

  static String baseToJson(Map<String, int> baseMap) => jsonEncode(baseMap);
}