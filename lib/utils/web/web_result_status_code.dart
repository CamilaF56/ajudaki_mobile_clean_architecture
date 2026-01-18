import 'web_result_status_type.dart';

class WebResultStatusCode {
  WebResultStatusCode(this.code);

  final int code;

  bool get isInformational => code >= 200 && code < 300;
  bool get isSuccess => code >= 200 && code < 300;
  bool get isRedirection => code >= 300 && code < 400;
  bool get isClientError => code >= 400 && code < 500;
  bool get isServerError => code >= 500 && code < 600;

  WebResultStatusType getStatusType(final int code) {
    if (isInformational) {
      return WebResultStatusType.informational;
    }
    if (isSuccess) {
      return WebResultStatusType.success;
    }
    if (isRedirection) {
      return WebResultStatusType.redirection;
    }
    if (isClientError) {
      return WebResultStatusType.clientError;
    }
    if (isServerError) {
      return WebResultStatusType.serverError;
    }
    return WebResultStatusType.unknown;
  }
}
