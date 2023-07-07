// Mocks generated by Mockito 5.4.1 from annotations
// in cist_keion_app/test/feature/reservation/domain/usecases/get_reservations_next_week_test.dart.
// Do not manually edit this file.

// @dart=2.19

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cist_keion_app/core/error/failure/failure.dart' as _i5;
import 'package:cist_keion_app/feature/reservation/domain/entities/reservation.dart'
    as _i6;
import 'package:cist_keion_app/feature/reservation/domain/repositories/reservation_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ReservationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockReservationRepository extends _i1.Mock
    implements _i3.ReservationRepository {
  MockReservationRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<
      _i2.Either<_i5.Failure, List<_i6.Reservation>>> getReservationsBetween(
    DateTime? startDate,
    DateTime? endDate,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getReservationsBetween,
          [
            startDate,
            endDate,
          ],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.Reservation>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.Reservation>>(
          this,
          Invocation.method(
            #getReservationsBetween,
            [
              startDate,
              endDate,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Reservation>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> addReservations(
          List<_i6.Reservation>? reservations) =>
      (super.noSuchMethod(
        Invocation.method(
          #addReservations,
          [reservations],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #addReservations,
            [reservations],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>> deleteReservations(
          List<String>? reservationIds) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteReservations,
          [reservationIds],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>.value(
            _FakeEither_0<_i5.Failure, _i2.Unit>(
          this,
          Invocation.method(
            #deleteReservations,
            [reservationIds],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i2.Unit>>);
}
