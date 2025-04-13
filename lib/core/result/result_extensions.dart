import 'package:absence_manager/core/result/result.dart';

/// Extension to simplify handling of [Result] outcomes.
extension ResultHandler<T> on Result<T> {
  /// Executes [onSuccess] if the result is Ok, or [onError] if it's Error.
  Future<void> handle({
    required Future<void> Function(T data) onSuccess,
    required Future<void> Function(Exception error) onError,
  }) async {
    switch (this) {
      case Ok(:final value):
        await onSuccess(value);
        break;
      case Error(:final error):
        await onError(error);
        break;
    }
  }
}
