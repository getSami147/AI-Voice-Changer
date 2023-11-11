class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppException {
  InternetException([
    String? message,
  ]) : super(message, "No Internet Connection");
}

class RequestTimeOut extends AppException {
  RequestTimeOut([
    String? message,
  ]) : super(message, "Request Time Out");
}

class ServerExceptions extends AppException {
  ServerExceptions([
    String? message,
  ]) : super(message, "Internal Server Error");
}

class NotFoundExceptions extends AppException {
  NotFoundExceptions([
    String? message,
  ]) : super(message, "Not Found");
}

class BadRequestExceptions extends AppException {
  BadRequestExceptions([
    String? message,
  ]) : super(message, "Bad Request");
}

class FatchDataExceptions extends AppException {
  FatchDataExceptions([
    String? message,
  ]) : super(message, "");
}
