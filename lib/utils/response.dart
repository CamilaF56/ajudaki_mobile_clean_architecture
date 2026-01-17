class Response<T> {
    Response(
    this.isSuccess, [
      this.data]
  );

  final bool isSuccess;
  final T? data;
}
