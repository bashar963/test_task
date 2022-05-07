class LaunchUrlException implements Exception {
  final dynamic message;

  LaunchUrlException([this.message]);

  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "LaunchUrlException";
    return "LaunchUrlException: $message";
  }
}
