import 'package:floor/floor.dart';

@Entity(tableName: 'Party')
class PartyDatabaseEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int pokemonId;

  PartyDatabaseEntity({this.id, required this.pokemonId});
}