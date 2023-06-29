import 'package:cist_keion_app/feature/auth/data/datasources/remote/firestore_data_source.dart';
import 'package:cist_keion_app/feature/reservation/data/datasources/reservation_remote_data_source.dart';
import 'package:cist_keion_app/feature/reservation/data/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  late RemoteDataSourceImpl dataSource;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    dataSource = RemoteDataSourceImpl(firestore: mockFirestore);
  });

  final tFirestoreData = firestoreDataReader(
      firestoreReservationDataPath, firestoreTimestampFieldName);

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

  final tReservationModels = tFirestoreData.map((e) =>
      ReservationModel.fromJson(
          {'id': e['id'] as String, ...e['value'] as Map<String, dynamic>}));
  final tSuitableModel = tReservationModels.where((element) =>
      element.date.compareTo(tStartDate) >= 0 &&
      element.date.compareTo(tEndDate) <= 0);

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
}
