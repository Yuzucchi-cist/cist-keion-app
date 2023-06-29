import '../failure.dart';
import 'reservation_failure_state.dart';

class ReservationFailure extends Failure {
  ReservationFailure([this.state = ReservationFailureState.unexpected])
      : super([state]);

  factory ReservationFailure.fromCode(String code) {
    late ReservationFailureState state;
    switch (code) {
      case 'no-data':
        state = ReservationFailureState.noData;
      default:
        state = ReservationFailureState.unexpected;
    }
    return ReservationFailure(state);
  }

  final ReservationFailureState state;
}
