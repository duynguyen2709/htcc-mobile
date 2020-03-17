class Result<T> {
  Result._();

  factory Result.success(String message, T data) = Success<T>;
  factory Result.error(String foo) = Error<T>;
}

class Success<T> extends Result<T> {
  Success(this.msg, this.data): super._();

  final String msg;
  final T data;
}

class Error<T> extends Result<T> {
  Error(this.msg): super._();

  final String msg;
}