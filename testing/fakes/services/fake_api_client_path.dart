class FakeApiClientPath<T> {
    FakeApiClientPath(
    Map<String, T> map
  );

  Map<String, T> getAll(
    Map<String, T> map) {
    return map;
  }
}
