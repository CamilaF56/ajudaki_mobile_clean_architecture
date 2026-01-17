class Response<T> {
    Response(
    this.isSuccess, [
      this.data,
      this.message]
  );

  final bool isSuccess;
  final T? data;
  final String? message;
}
