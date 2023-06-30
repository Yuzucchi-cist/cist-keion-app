import 'package:cist_keion_app/feature/auth/data/models/firestore/belonging_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/firestore_user_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/institute_grade_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/user_state_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  final tFirestoreJsonData = firestoreDataReader(firestoreUserDataPath, []);

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

  test('should create model from json data', () {
    // act
    final result = FirestoreUserModel.fromFirestoreJson(tId, tFirestoreDatum);
    // assert
    expect(result, tFirestoreUserModel);
  });

  test('should should return suitable fire store map from model', () {
    // act
    final result = tFirestoreUserModel.toFirestoreJson();
    // assert
    expect(result, tFirestoreDatum);
  });
}
