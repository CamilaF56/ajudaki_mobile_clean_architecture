import 'dart:convert';

T? fromJson<T>(
  final String? string,
  final T Function(Map<String, dynamic> json)? fromJson,
) {
  if (string == null || fromJson == null) {
    return null;
  }

  final decoded = jsonDecode(string);

  if (decoded is Map<String, dynamic>) {
    return fromJson(decoded);
  }

  throw FormatException(
    'Erro de formato - esperava um objeto JSON para conversão em $T',
  );
}
