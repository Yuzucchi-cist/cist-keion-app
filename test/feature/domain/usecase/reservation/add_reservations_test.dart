import 'package:cist_keion_app/feature/domain/entity/reservation/reservation.dart';
import 'package:cist_keion_app/feature/domain/entity/reservation/reserved_member.dart';
import 'package:cist_keion_app/feature/domain/repository/reservation_repository.dart';
import 'package:cist_keion_app/feature/domain/usecase/reservation/add_reservations.dart';
import 'package:cist_keion_app/feature/domain/value/institute_time.dart';
import 'package:clock/clock.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_reservations_test.mocks.dart';

@GenerateMocks([ReservationRepository])
void main() {
  late AddReservations usecase;
  late MockReservationRepository mockReservationRepository;

  setUp(() {
    mockReservationRepository = MockReservationRepository();
    usecase = AddReservations(reservationRepository: mockReservationRepository);
  });

  final tToday = DateTime(2023, 06, 07);
  final tEndDateOfNextWeek = DateTime(2023, 06, 18);

  final params = [
    AddReservationsParam(
      title: 'testTitle',
      date: DateTime(2023, 06, 15),
      time: InstituteTime.first,
      reservedMemberId: 'testMemberId',
      reservedMemberName: 'testMemberName',
    ),
    AddReservationsParam(
      title: 'testTitle2',
      date: DateTime(2023, 06, 25),
      time: InstituteTime.first,
      reservedMemberId: 'testMemberId2',
      reservedMemberName: 'testMemberName2',
    ),
  ];
  final tReservationList = params
      .map((param) => Reservation(
          id: '',
          title: param.title,
          date: param.date,
          reservedMember: ReservedMember(
              id: param.reservedMemberId, name: param.reservedMemberName),
          time: param.time))
      .toList();

  final tSuitableReservationList = tReservationList
      .where((reservation) =>
          reservation.date.isAfter(tToday) &&
          reservation.date.isBefore(tEndDateOfNextWeek))
      .toList();

  test('should call the repository to add reservations list to data base',
      () async {
    // arrange
    when(mockReservationRepository.addReservations(any))
        .thenAnswer((realInvocation) async => const Right(unit));
    // act
    final result =
        await withClock(Clock.fixed(tToday), () async => usecase(params));
    // assert
    verify(mockReservationRepository.addReservations(tSuitableReservationList));
    expect(result, const Right(unit));
  });
}
