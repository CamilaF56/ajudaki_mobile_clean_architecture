import 'web_result_status_type.dart';

class WebResultStatusCode {
  WebResultStatusCode(this.code);

  final int code;

  WebResultStatusType getStatusType(final int code) {
    switch (code ~/ 100) {
      case 1:
        return WebResultStatusType.informational;
      case 2:
        return WebResultStatusType.success;
      case 3:
        return WebResultStatusType.redirection;
      case 4:
        return WebResultStatusType.clientError;
      case 5:
        return WebResultStatusType.serverError;
      default:
        return WebResultStatusType.unknown;
    }
  }
}
