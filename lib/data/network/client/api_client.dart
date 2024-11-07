import 'package:dio/dio.dart';
import '../../../domain/exceptions/network_exception.dart';
import '../entity/pokemon_entity.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl))
          ..interceptors
              .add(LogInterceptor(requestBody: true, responseBody: true));

  Future<List<PokemonEntity>> fetchPokemons() async {
    final response = await _dio.get("/pokemon");
    if (response.statusCode != null && response.statusCode! >= 400) {
      throw NetworkException(
        statusCode: response.statusCode!,
        message: response.statusMessage,
      );
    }

    final List<dynamic> pokemonList = response.data as List<dynamic>;

    return (pokemonList)
        .map((json) => PokemonEntity.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}