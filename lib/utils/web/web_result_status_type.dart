/// Representa o tipo categorizado de uma resposta HTTP.
///
/// Classificação baseada no padrão HTTP:
/// - 1xx → Informacional
/// - 2xx → Sucesso
/// - 3xx → Redirecionamento
/// - 4xx → Erro do cliente
/// - 5xx → Erro do servidor
/// - Outros → Desconhecido
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
