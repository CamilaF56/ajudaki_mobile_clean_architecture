class FakeApiClientPath<T> {
    FakeApiClientPath(
    Map<String, T> map
  );

  Map<String, T> getAll({
    required Map<String, T> map
  }) {
    return map;
  }
}
