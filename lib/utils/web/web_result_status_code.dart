import 'web_result_status_type.dart';

class WebResultStatusCode {
  WebResultStatusCode(this.code);

  final int code;

  WebResultStatusType getStatusType(final int code) {
    if (code >= 100 && code < 200) {
      return WebResultStatusType.informational;
    } else if (code >= 200 && code < 300) {
      return WebResultStatusType.success;
    } else if (code >= 300 && code < 400) {
      return WebResultStatusType.redirection;
    } else if (code >= 400 && code < 500) {
      return WebResultStatusType.clientError;
    } else if (code >= 500 && code < 600) {
      return WebResultStatusType.serverError;
    } else {
      return WebResultStatusType.unknown;
    }
  }
}
