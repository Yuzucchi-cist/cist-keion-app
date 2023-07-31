import 'package:cist_keion_app/feature/domain/repository/reservation_repository.dart';
import 'package:cist_keion_app/feature/domain/usecase/reservation/delete_reservations.dart';
import 'package:cist_keion_app/feature/domain/value/institute_time.dart';
import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_reservations_test.mocks.dart';

@GenerateMocks([ReservationRepository])
void main() {
  late DeleteReservations usecase;
  late MockReservationRepository mockReservationRepository;

  setUp(() {
    mockReservationRepository = MockReservationRepository();
    usecase =
        DeleteReservations(reservationRepository: mockReservationRepository);
  });

  const tMemberId = 'testMId1';
  final tToday = DateTime(2023, 06, 07);
  final tEndDateOfNextWeek = DateTime(2023, 06, 18);

  final tReservationParams = [
    ReservationParams(
      reservationId: 'testRId1',
      title: 'testTitle',
      date: DateTime(2023, 06, 07, 12),
      time: InstituteTime.first,
      reservedMemberId: 'testMId1',
    ),
    ReservationParams(
      reservationId: 'testRId2',
      title: 'testTitle',
      date: DateTime(2023, 06, 06, 12),
      time: InstituteTime.first,
      reservedMemberId: 'testMId2',
    ),
  ];
  final tParams = DeleteReservationsParams(
      memberId: tMemberId, reservationParams: tReservationParams);

  final tSuitableReservationList = tReservationParams
      .where((param) => param.reservedMemberId == tMemberId)
      .where((param) =>
          param.date.isAfter(tToday) && param.date.isBefore(tEndDateOfNextWeek))
      .map((param) => param.reservationId)
      .toList();

  test('should call the repository to delete reservations', () async {
    // arrange
    when(mockReservationRepository.deleteReservations(any))
        .thenAnswer((realInvocation) async => const Right(unit));
    // act
    final result =
        await withClock(Clock.fixed(tToday), () async => usecase(tParams));
    // assert
    verify(
        mockReservationRepository.deleteReservations(tSuitableReservationList));
    expect(result, const Right(unit));
  });
}
