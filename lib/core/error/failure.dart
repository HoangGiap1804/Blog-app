class Failure {
  final String message;
  Failure({required this.message});
}

class FailureResponse extends Failure {
  final String statusCode;
  FailureResponse({required super.message, required this.statusCode});
}
