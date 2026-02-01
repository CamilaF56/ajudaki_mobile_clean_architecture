class ApiClientConfig {
  const ApiClientConfig(
    this.host,
    this.port,
    this.basePath,
  );

  final String host;
  final int port;
  final String basePath;

  String get authority => '$host:$port';

  String createUnencodedPath(final String endpointPath) {
    return '$basePath/$endpointPath';
  }
}
