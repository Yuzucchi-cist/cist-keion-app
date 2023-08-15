// ignore_for_file: avoid_redundant_argument_values

import 'package:cist_keion_app/feature/data/datasource/member_detail_remote_data_source.dart';
import 'package:cist_keion_app/feature/data/datasource/reservation_remote_data_source.dart';
import 'package:cist_keion_app/feature/data/model/reservation/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  late ReservationRemoteDataSourceImpl dataSource;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    dataSource = ReservationRemoteDataSourceImpl(firestore: mockFirestore);
  });

  final tFirestoreData = firestoreDataReader(
      firestoreReservationDataPath, firestoreTimestampFieldName);

  void setUserDataToFirestore() {
    for (final data in tFirestoreData) {
      final reservedMember = (data['value']
          as Map<String, dynamic>)['reserved_member'] as Map<String, dynamic>;
      final reservedMemberReference = mockFirestore
          .collection(authCollectionName)
          .doc(reservedMember['id'] as String);
      reservedMemberReference.set(reservedMember);
    }
  }

  void setDataToFirestore() {
    for (final data in tFirestoreData) {
      final reservedMember = (data['value']
          as Map<String, dynamic>)['reserved_member'] as Map<String, dynamic>;
      final reservedMemberReference = mockFirestore
          .collection(authCollectionName)
          .doc(reservedMember['id'] as String);
      reservedMemberReference.set(reservedMember);
      final value = (data['value'] as Map<String, dynamic>).map((key, value) =>
          MapEntry(
              key,
              key == 'reserved_member'
                  ? {
                      'id': reservedMemberReference,
                      'name': reservedMember['name']
                    }
                  : value));
      mockFirestore
          .collection(reservationCollectionName)
          .doc(data['id'] as String)
          .set(value);
    }
  }

  final tStartDate = Timestamp.fromDate(DateTime(2023, 06, 25));
  final tEndDate = Timestamp.fromDate(DateTime(2023, 07, 01));

  final tReservationModels = tFirestoreData
      .map((e) => ReservationModel.fromJson(
          {'id': e['id'] as String, ...e['value'] as Map<String, dynamic>}))
      .toList();
  final tSuitableModel = tReservationModels
      .where((element) =>
          element.date.compareTo(tStartDate) >= 0 &&
          element.date.compareTo(tEndDate) <= 0)
      .toList();

  group('getMemberByStudentNumber', () {
    test('should return member model when the FireStore is successful',
        () async {
      // arrange
      setDataToFirestore();
      // act
      final result =
          await dataSource.getReservationsBetween(tStartDate, tEndDate);
      // assert
      expect(result, unorderedEquals(tSuitableModel));
    });

    /*
    firebaseがエラーを出すケース
    test('should throw the FirestoreException when data does not exist',
        () async {
      // arrange
      setDataToFirestore();
      try {
        // act
        await dataSource.getReservationsBetween(tStartDate, tEndDate);
        fail('');
      } on FirestoreException catch (e) {
        expect(e.code, 'firestoreError');
      } catch (e) {
        fail('Not-expect object was thrown: $e');
      }
    });
     */
  });

  group('addReservations', () {
    test('should call firestore to add data', () async {
      // arrange
      setUserDataToFirestore();
      // act
      await dataSource.addReservations(tReservationModels);

      // assert
      final snapshot =
          await mockFirestore.collection(reservationCollectionName).get();
      final result = snapshot.docs
          .map<ReservationModel>((e) => ReservationModel.fromFirestoreJson(
              '',
              e.data().map((key, value) {
                if (key == 'reserved_member') {
                  return MapEntry(key, {
                    'id': ((value as Map)['id'] as DocumentReference).id,
                    'name': value['name'],
                  });
                }
                return MapEntry(key, value);
              })))
          .toList();
      expect(
          result,
          unorderedEquals(
              tReservationModels.map((model) => model.copyWith(id: ''))));
    });

    /*
    test('should throw the FirestoreException when data does not exist',
        () async {
      // arrange
      setDataToFirestore();
      try {
        // act
        await dataSource.addReservations(tReservationModels);
        fail('');
      } on FirestoreException catch (e) {
        expect(e.code, 'firestoreError');
      } catch (e) {
        fail('Not-expect object was thrown: $e');
      }
    });
     */
  });

  group('deleteReservation', () {
    final tId = tFirestoreData.first['id'] as String;
    final deletedModels = [...tReservationModels];
    deletedModels.removeWhere((model) => model.id == tId);
    test('should call firestore to delete data', () async {
      // arrange
      setDataToFirestore();
      // act
      await dataSource.deleteReservations([tId]);
      // assert
      final snapshot =
          await mockFirestore.collection(reservationCollectionName).get();
      final result = snapshot.docs
          .map<ReservationModel>((e) => ReservationModel.fromFirestoreJson(
              e.id,
              e.data().map((key, value) {
                if (key == 'reserved_member') {
                  return MapEntry(key, {
                    'id': ((value as Map)['id'] as DocumentReference).id,
                    'name': value['name'],
                  });
                }
                return MapEntry(key, value);
              })))
          .toList();
      expect(result, unorderedEquals(deletedModels));
    });
    /*
    test('should throw the FirestoreException when data does not exist',
        () async {
      // arrange
      setDataToFirestore();
      try {
        // act
        await dataSource.addReservations(tReservationModels);
        fail('');
      } on FirestoreException catch (e) {
        expect(e.code, 'firestoreError');
      } catch (e) {
        fail('Not-expect object was thrown: $e');
      }
    });
     */
  });
}
