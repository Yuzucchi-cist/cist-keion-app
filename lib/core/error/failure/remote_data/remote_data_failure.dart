import '../failure.dart';
import 'remote_data_failure_state.dart';

class RemoteDataFailure extends Failure {
  RemoteDataFailure([this.state = RemoteDataFailureState.unexpected])
      : super([state]);
  factory RemoteDataFailure.fromExceptionCode(String code) {
    RemoteDataFailureState state;
    switch (code) {
      case 'no-data':
        state = RemoteDataFailureState.noData;
      default:
        state = RemoteDataFailureState.unexpected;
    }
    return RemoteDataFailure(state);
  }

  final RemoteDataFailureState state;
}
