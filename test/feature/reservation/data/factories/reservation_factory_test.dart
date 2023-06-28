import 'package:cist_keion_app/feature/reservation/data/factories/institute_time_factory.dart';
import 'package:cist_keion_app/feature/reservation/data/factories/reservation_factory.dart';
import 'package:cist_keion_app/feature/reservation/data/factories/reserved_member_factory.dart';
import 'package:cist_keion_app/feature/reservation/data/models/reservation_model.dart';
import 'package:cist_keion_app/feature/reservation/data/models/reserved_member_model.dart';
import 'package:cist_keion_app/feature/reservation/domain/entities/reservation.dart';
import 'package:cist_keion_app/feature/reservation/domain/values/institute_time.dart';
import 'package:cist_keion_app/feature/reservation/domain/values/reserved_member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reservation_factory_test.mocks.dart';

@GenerateMocks([ReservedMemberFactory, InstituteTimeFactory])
void main() {
  late ReservationFactory factory;
  late MockReservedMemberFactory mockReservedMemberFactory;
  late MockInstituteTimeFactory mockInstituteTimeFactory;

  setUp(() {
    mockReservedMemberFactory = MockReservedMemberFactory();
    mockInstituteTimeFactory = MockInstituteTimeFactory();
    factory = ReservationFactory(
      reservedMemberFactory: mockReservedMemberFactory,
      instituteTimeFactory: mockInstituteTimeFactory,
    );
  });

  const tId = 'testId';
  const tTitle = 'testTitle';
  final tDate = DateTime(2023, 06, 25);
  const tReservedMember = ReservedMember(id: 'testMemberId', name: 'testName');
  const tTime = InstituteTime.first;
  final tCreatedAt = DateTime(2023, 06, 23, 06, 21);
  final tUpdatedAt = DateTime(2023, 06, 23, 06, 21);

  final tValue = Reservation(
      id: tId,
      title: tTitle,
      date: tDate,
      reservedMember: tReservedMember,
      time: tTime,
      createdAt: tCreatedAt,
      updatedAt: tUpdatedAt);

  final tReservedMemberModel =
      ReservedMemberModel(id: tReservedMember.id, name: tReservedMember.name);
  final tModel = ReservationModel(
      id: tId,
      title: tTitle,
      date: Timestamp.fromDate(tDate),
      time: tTime.name,
      reservedMember: tReservedMemberModel,
      createdAt: Timestamp.fromDate(tCreatedAt),
      updatedAt: Timestamp.fromDate(tCreatedAt));

  final tMemberParams =
      ReservedMemberParams(id: 'testMemberId', name: 'testName');
  final tParams = ReservationParams(
      id: tId,
      title: tTitle,
      date: tDate,
      reservedMemberParams: tMemberParams,
      time: 'first',
      createdAt: tCreatedAt,
      updatedAt: tUpdatedAt);

  group('create', () {
    test('should return reservation', () {
      // arrange
      when(mockReservedMemberFactory.create(any)).thenReturn(tReservedMember);
      when(mockInstituteTimeFactory.create(any)).thenReturn(tTime);
      // act
      final result = factory.create(tParams);
      // assert
      verify(mockReservedMemberFactory.create(tMemberParams));
      verify(mockInstituteTimeFactory.create(tParams.time));
      expect(result, tValue);
    });
  });

  group('createFromModel', () {
    test('should return reservation from model', () {
      // arrange
      when(mockReservedMemberFactory.createFromModel(any))
          .thenReturn(tReservedMember);
      when(mockInstituteTimeFactory.createFromModel(any)).thenReturn(tTime);
      // act
      final result = factory.createFromModel(tModel);
      // assert
      verify(mockReservedMemberFactory.createFromModel(tReservedMemberModel));
      verify(mockInstituteTimeFactory.createFromModel(tTime.name));
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should return model', () {
      // arrange
      when(mockReservedMemberFactory.convertToModel(any))
          .thenReturn(tReservedMemberModel);
      when(mockInstituteTimeFactory.convertToModel(any)).thenReturn(tTime.name);
      // act
      final result = factory.convertToModel(tValue);
      // assert
      verify(mockReservedMemberFactory.convertToModel(tReservedMember));
      verify(mockInstituteTimeFactory.convertToModel(tTime));
      expect(result, tModel);
    });

    test('should return model when createdAt or updatedAt is null', () {
      // arrange
      final tValueWithNull = tValue.copyWith(createdAt: null, updatedAt: null);
      final tModelWithNull = tModel.copyWith(createdAt: null, updatedAt: null);
      when(mockReservedMemberFactory.convertToModel(any))
          .thenReturn(tReservedMemberModel);
      when(mockInstituteTimeFactory.convertToModel(any)).thenReturn(tTime.name);
      // act
      final result = factory.convertToModel(tValueWithNull);
      // assert
      verify(mockReservedMemberFactory.convertToModel(tReservedMember));
      verify(mockInstituteTimeFactory.convertToModel(tTime));
      expect(result, tModelWithNull);
    });
  });
}
