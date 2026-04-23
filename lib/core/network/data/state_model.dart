sealed class StateModel<T> {}

final class Success<T> extends StateModel<T> {
  final T data;
  Success(this.data);
}

final class Erorr<T> extends StateModel<T> {
  final String message;
  Erorr(this.message);
}
