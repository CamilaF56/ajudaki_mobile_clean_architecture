class Response<T> {
  final bool isSuccess;
  final T? data;
  final String? message;

  Response(
    this.isSuccess, [
      this.data,
      this.message]
  );
}
