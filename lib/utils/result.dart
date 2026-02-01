class Result<T> {
    Result(
    this.isSuccess, [
      this.value]
  );

  final bool isSuccess;
  final T? value;
}
