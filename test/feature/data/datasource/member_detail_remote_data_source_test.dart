import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/feature/data/datasource/member_detail_remote_data_source.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/belonging_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/institute_grade_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/member_detail_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/user_state_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  late MemberDetailRemoteDataSource dataSource;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    dataSource = MemberDetailRemoteDataSourceImpl(firestore: mockFirestore);
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

  final tMemberDetailModelList = tFirestoreJsonData.map((json) {
    final id = json['id'] as String;
    final jsonValue = json['value'] as Map<String, dynamic>;
    final studentNumber = jsonValue['student_number'] as String;
    final name = jsonValue['name'] as String;
    final instituteGrade = InstituteGradeModel.values
        .byName(jsonValue['institute_grade'] as String);
    final userState =
        UserStateModel.values.byName(jsonValue['user_state'] as String);
    final belongings = (jsonValue['belongings'] as List<dynamic>)
        .map((belonging) => BelongingModel(
            id: (belonging as Map<String, dynamic>)['id'] as String,
            type: BelongingType.values.byName(belonging['type'] as String),
            name: belonging['name'] as String))
        .toList();
    final isAdmin = jsonValue['is_admin'] as bool;

    return MemberDetailModel(
      id: id,
      studentNumber: studentNumber,
      name: name,
      instituteGrade: instituteGrade,
      userState: userState,
      belongings: belongings,
      isAdmin: isAdmin,
    );
  }).toList();

  final tMemberDetailModel = tMemberDetailModelList.first;

  group('getMemberByStudentNumber', () {
    test('should return member model when the FireStore is successful',
        () async {
      // arrange
      setFirestoreToData();
      // act
      final result =
          await dataSource.getByStudentNumber(tMemberDetailModel.studentNumber);
      // assert
      expect(result, tMemberDetailModel);
    });

    test('should throw the FirestoreException when data does not exist',
        () async {
      // arrange
      setFirestoreToData();
      try {
        // act
        await dataSource.getByStudentNumber('b0000000');
        fail('');
      } on FirestoreException catch (e) {
        expect(e.code, 'no-member');
      } catch (e) {
        fail('Not-expect object was thrown: $e');
      }
    });
  });

  group('getAll', () {
    test('should return member model list when the FireStore is successful',
        () async {
      // arrange
      setFirestoreToData();
      // act
      final result = await dataSource.getAll();
      // assert
      expect(result, unorderedEquals(tMemberDetailModelList));
    });

    // test('should throw firestore exception ', () => null);
  });

  group('add', () {
    test('should call firestore to add data', () async {
      // act
      await dataSource.add(tMemberDetailModelList);
      // assert
      final result = (await mockFirestore.collection(authCollectionName).get())
          .docs
          .map((doc) => doc.data());
      expect(
          result,
          unorderedEquals(
              tMemberDetailModelList.map((model) => model.toFirestoreJson())));
    });

    test('should return added data when firestore is successful', () async {
      // act
      final result = await dataSource.add(tMemberDetailModelList);
      // assert
      final expected = (await mockFirestore
              .collection(authCollectionName)
              .get())
          .docs
          .map((doc) => MemberDetailModel.fromFirestoreJson(doc.id, doc.data()))
          .toList();
      expect(result, unorderedEquals(expected));
    });

    // test('should throw firestore exception ', () => null);
  });
}
