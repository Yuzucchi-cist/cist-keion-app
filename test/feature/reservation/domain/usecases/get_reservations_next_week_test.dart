import 'package:cist_keion_app/core/usecases/usecase.dart';
import 'package:cist_keion_app/feature/reservation/domain/entities/reservation.dart';
import 'package:cist_keion_app/feature/reservation/domain/repositories/reservation_repository.dart';
import 'package:cist_keion_app/feature/reservation/domain/usecases/get_reservations_next_week.dart';
import 'package:cist_keion_app/feature/reservation/domain/values/institute_time.dart';
import 'package:cist_keion_app/feature/reservation/domain/values/reserved_member.dart';
import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_reservations_next_week_test.mocks.dart';

@GenerateMocks([ReservationRepository])
void main() {
  late GetReservationsNextWeek usecase;
  late MockReservationRepository mockReservationRepository;

  setUp(() {
    mockReservationRepository = MockReservationRepository();
    usecase = GetReservationsNextWeek(
        reservationRepository: mockReservationRepository);
  });

  final tToday = DateTime(2023, 06, 26);
  final tStartDateOfNextWeek = tToday
      .subtract(Duration(days: tToday.weekday))
      .add(const Duration(days: DateTime.daysPerWeek));
  final tEndDateOfNextWeek =
      tStartDateOfNextWeek.add(const Duration(days: DateTime.daysPerWeek));

  const tMember = ReservedMember(id: 'testId', name: 'testName');
  final tReservation = Reservation(
    id: 'testId',
    title: 'testTitle',
    date: DateTime(2023, 06, 26),
    reservedMember: tMember,
    time: InstituteTime.first,
  );

  final tReservationList = [
    tReservation,
    tReservation.copyWith(
        id: 'testId2', title: 'testTitle2', date: DateTime(2023, 07, 10)),
  ];

  final tSuitableReservationList = tReservationList
      .where((reservation) =>
          reservation.date.isAfter(tStartDateOfNextWeek) &&
          reservation.date.isBefore(tEndDateOfNextWeek))
      .toList();

  test('should return suitable reservation list from repository', () async {
    // arrange
    when(mockReservationRepository.getReservationsBetween(any, any))
        .thenAnswer((realInvocation) async => Right(tSuitableReservationList));
    // act
    final result =
        await withClock(Clock.fixed(tToday), () async => usecase(NoParams()));
    // assert
    verify(mockReservationRepository.getReservationsBetween(
        tStartDateOfNextWeek, tEndDateOfNextWeek));
    expect(result, Right(tSuitableReservationList));
  });
}
