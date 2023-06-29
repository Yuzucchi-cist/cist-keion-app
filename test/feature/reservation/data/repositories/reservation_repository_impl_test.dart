// ignore_for_file: avoid_redundant_argument_values

import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/core/error/failure/reservation/reservation_failure.dart';
import 'package:cist_keion_app/core/error/failure/reservation/reservation_failure_state.dart';
import 'package:cist_keion_app/core/network/network_info.dart';
import 'package:cist_keion_app/feature/reservation/data/datasources/reservation_local_data_source.dart';
import 'package:cist_keion_app/feature/reservation/data/datasources/reservation_remote_data_source.dart';
import 'package:cist_keion_app/feature/reservation/data/factories/reservation_factory.dart';
import 'package:cist_keion_app/feature/reservation/data/models/reservation_model.dart';
import 'package:cist_keion_app/feature/reservation/data/models/reserved_member_model.dart';
import 'package:cist_keion_app/feature/reservation/data/repositories/reservation_repository_impl.dart';
import 'package:cist_keion_app/feature/reservation/domain/entities/reservation.dart';
import 'package:cist_keion_app/feature/reservation/domain/values/institute_time.dart';
import 'package:cist_keion_app/feature/reservation/domain/values/reserved_member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reservation_repository_impl_test.mocks.dart';

@GenerateMocks([
  ReservationRemoteDataSource,
  ReservationLocalDataSource,
  NetworkInfo,
  ReservationFactory
])
void main() {
  late ReservationRepositoryImpl repository;
  late MockReservationRemoteDataSource mockReservationRemoteDataSource;
  late MockReservationLocalDataSource mockReservationLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockReservationFactory mockReservationFactory;

  setUp(() {
    mockReservationRemoteDataSource = MockReservationRemoteDataSource();
    mockReservationLocalDataSource = MockReservationLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockReservationFactory = MockReservationFactory();
    repository = ReservationRepositoryImpl(
        remoteDataSource: mockReservationRemoteDataSource,
        localDataSource: mockReservationLocalDataSource,
        networkInfo: mockNetworkInfo,
        reservationFactory: mockReservationFactory);
  });

  void checkOnline(
      {required void Function() arrange, required void Function() act}) {
    test('should check online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      arrange();
      // act
      act();
      // assert
      verify(mockNetworkInfo.isConnected);
    });
  }

  final tReservationModel = ReservationModel(
      id: 'testId',
      title: 'testTitle',
      date: Timestamp.fromDate(DateTime(2023, 06, 25)),
      time: 'first',
      reservedMember:
          const ReservedMemberModel(id: 'testId', name: 'testName'));
  final tReservationModelList = [
    tReservationModel,
    tReservationModel.copyWith(id: 'testId2')
  ];
  final tReservationList = tReservationModelList.map((e) => Reservation(
      id: e.id,
      title: e.title,
      date: e.date.toDate(),
      reservedMember:
          ReservedMember(id: e.reservedMember.id, name: e.reservedMember.name),
      time: InstituteTime.values.byName(e.time),
      createdAt: e.createdAt?.toDate(),
      updatedAt: e.updatedAt?.toDate()));

  group('getReservationsBetween', () {
    final tStartDate = DateTime(2023, 06, 25);
    final tEndDate = DateTime(2023, 07, 01);

    checkOnline(arrange: () {
      when(mockReservationRemoteDataSource.getReservationsBetween(any, any))
          .thenAnswer((realInvocation) async => tReservationModelList);
      when(mockReservationFactory.createFromModel(any))
          .thenReturn(tReservationList.first);
      when(mockReservationLocalDataSource.cacheReservations(any))
          .thenAnswer((realInvocation) async {});
    }, act: () async {
      await repository.getReservationsBetween(tStartDate, tEndDate);
    });

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should return reservations when data source is successful',
          () async {
        // arrange
        when(mockReservationRemoteDataSource.getReservationsBetween(any, any))
            .thenAnswer((realInvocation) async => tReservationModelList);
        tReservationModelList.asMap().forEach((i, model) =>
            when(mockReservationFactory.createFromModel(model))
                .thenReturn(tReservationList.elementAt(i)));
        when(mockReservationLocalDataSource.cacheReservations(any))
            .thenAnswer((realInvocation) async {});
        // act
        final result =
            (await repository.getReservationsBetween(tStartDate, tEndDate))
                .fold((l) => l, (r) => r);
        // assert
        verify(mockReservationRemoteDataSource.getReservationsBetween(
            Timestamp.fromDate(tStartDate), Timestamp.fromDate(tEndDate)));
        for (final model in tReservationModelList) {
          verify(mockReservationFactory.createFromModel(model));
        }
        expect(result, unorderedEquals(tReservationList));
      });

      test('should cache data when datasource is successful', () async {
        // arrange
        when(mockReservationRemoteDataSource.getReservationsBetween(any, any))
            .thenAnswer((realInvocation) async => tReservationModelList);
        tReservationModelList.asMap().forEach((i, model) =>
            when(mockReservationFactory.createFromModel(model))
                .thenReturn(tReservationList.elementAt(i)));
        when(mockReservationLocalDataSource.cacheReservations(any))
            .thenAnswer((realInvocation) async {});
        // act
        await repository.getReservationsBetween(tStartDate, tEndDate);
        // assert
        verify(mockReservationLocalDataSource
            .cacheReservations(tReservationModelList));
      });

      test('should return firestore failure when datasource failed', () async {
        // arrange
        when(mockReservationRemoteDataSource.getReservationsBetween(any, any))
            .thenThrow(FirestoreException('no-data'));
        // act
        final result =
            await repository.getReservationsBetween(tStartDate, tEndDate);
        // assert
        verifyNever(mockReservationLocalDataSource.cacheReservations(any));
        expect(
            result, Left(ReservationFailure(ReservationFailureState.noData)));
      });
    });

    group('device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false));

      test('should return cache data when cache exists', () async {
        // arrange
        when(mockReservationLocalDataSource.getReservations())
            .thenAnswer((realInvocation) async => tReservationModelList);
        tReservationModelList.asMap().forEach((i, model) =>
            when(mockReservationFactory.createFromModel(model))
                .thenReturn(tReservationList.elementAt(i)));
        // act
        final result =
            (await repository.getReservationsBetween(tStartDate, tEndDate))
                .fold((l) => l, (r) => r);
        // assert
        verify(mockReservationLocalDataSource.getReservations());
        expect(result, unorderedEquals(tReservationList));
      });
    });
  });
}
