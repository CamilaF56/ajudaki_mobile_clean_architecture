enum WebResultStatusType {
  /// Resposta informacional (1xx)
  informational,

  /// Resposta bem-sucedida (2xx)
  success,

  /// Resposta de redirecionamento (3xx)
  redirection,

  /// Erro causado pelo cliente (4xx)
  clientError,

  /// Erro causado pelo servidor (5xx)
  serverError,

  /// Código desconhecido ou fora do padrão HTTP
  unknown,
}
