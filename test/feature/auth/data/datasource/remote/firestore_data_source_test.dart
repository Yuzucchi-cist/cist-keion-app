import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/feature/auth/data/datasources/remote/firestore_data_source.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/belonging_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/firestore_user_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/institute_grade_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/user_state_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  late FirestoreDataSource dataSource;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    dataSource = FirestoreDataSourceImpl(firestore: mockFirestore);
  });

  final tFirestoreJsonData = firestoreDataReader(firestoreUserDataPath, []);

  void setFirestoreToData() {
    for (final data in tFirestoreJsonData) {
      mockFirestore
          .collection(authCollectionName)
          .doc(data['id'] as String)
          .set(data['value'] as Map<String, dynamic>);
    }
  }

  final tId = tFirestoreJsonData.first['id'] as String;
  final tFirestoreDatum = (tFirestoreJsonData.first['value']
      as Map<String, dynamic>)
    ..removeWhere((key, value) => key == 'created_at' || key == 'updated_at');
  final tStudentNumber = tFirestoreDatum['student_number'] as String;
  final tName = tFirestoreDatum['name'] as String;
  final tInstituteGrade = InstituteGradeModel.values
      .byName(tFirestoreDatum['institute_grade'] as String);
  final tUserState =
      UserStateModel.values.byName(tFirestoreDatum['user_state'] as String);
  final tBelongings = (tFirestoreDatum['belongings'] as List<dynamic>)
      .map((belonging) => BelongingModel(
          id: (belonging as Map<String, dynamic>)['id'] as String,
          type: BelongingType.values.byName(belonging['type'] as String),
          name: belonging['name'] as String))
      .toList();

  final tFirestoreUserModel = FirestoreUserModel(
    id: tId,
    studentNumber: tStudentNumber,
    name: tName,
    instituteGrade: tInstituteGrade,
    userState: tUserState,
    belongings: tBelongings,
  );

  group('getMemberByStudentNumber', () {
    test('should return member model when the FireStore is successful',
        () async {
      // arrange
      setFirestoreToData();
      // act
      final result = await dataSource.getMemberByStudentNumber(tStudentNumber);
      // assert
      expect(result, tFirestoreUserModel);
    });

    test('should throw the FirestoreException when data does not exist',
        () async {
      // arrange
      setFirestoreToData();
      try {
        // act
        await dataSource.getMemberByStudentNumber('b0000000');
        fail('');
      } on FirestoreException catch (e) {
        expect(e.code, 'no-member');
      } catch (e) {
        fail('Not-expect object was thrown: $e');
      }
    });
  });
}
