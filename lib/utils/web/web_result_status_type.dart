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
  informational,
  success,
  redirection,
  clientError,
  serverError,
  unknown,
}
