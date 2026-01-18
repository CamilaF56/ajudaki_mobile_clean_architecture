import 'web_result_status_type.dart';

class WebResultStatus {
  WebResultStatus(this.code);

  int code;
  WebResultStatusType? _type;

  WebResultStatusType get type {
    _type ??= _getType(code);
    return _type!;
  }
  
  WebResultStatusType _getType(final int statusCode) {
    if (statusCode >= 100 && statusCode < 200) {
      return WebResultStatusType.informational;
    } if (statusCode >= 200 && statusCode < 300) {
      return WebResultStatusType.success;
    } if (statusCode >= 300 && statusCode < 400) {
      return WebResultStatusType.redirection;
    } if (statusCode >= 400 && statusCode < 500) {
      return WebResultStatusType.clientError;
    } if (statusCode >= 500 && statusCode < 600) {
      return WebResultStatusType.serverError;
    }
    return WebResultStatusType.unknown;
  }
}
