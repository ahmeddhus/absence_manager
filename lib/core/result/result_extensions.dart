import 'result.dart';

extension ResultHandler<T> on Result<T> {
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
