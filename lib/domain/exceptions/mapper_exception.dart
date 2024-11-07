class MapperException<T, U> implements Exception {
  final String message;

  MapperException(this.message);

  @override
  String toString() {
    return 'MapperException<$T, $U>: $message';
  }
}