import 'package:cist_keion_app/feature/auth/data/factories/belonging_factory.dart';
import 'package:cist_keion_app/feature/auth/data/factories/institute_grade_factory.dart';
import 'package:cist_keion_app/feature/auth/data/factories/member_factory.dart';
import 'package:cist_keion_app/feature/auth/data/factories/user_state_factory.dart';
import 'package:cist_keion_app/feature/auth/data/models/firebase_auth/firebase_auth_user_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/belonging_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/firestore_user_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/institute_grade_model.dart';
import 'package:cist_keion_app/feature/auth/data/models/firestore/user_state_model.dart';
import 'package:cist_keion_app/feature/auth/domain/entities/member.dart';
import 'package:cist_keion_app/feature/auth/domain/values/belongings/band.dart';
import 'package:cist_keion_app/feature/auth/domain/values/institute_grade.dart';
import 'package:cist_keion_app/feature/auth/domain/values/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'member_factory_test.mocks.dart';

@GenerateMocks([InstituteGradeFactory, UserStateFactory, BelongingFactory])
void main() {
  late MemberFactory factory;
  late MockInstituteGradeFactory mockInstituteGradeFactory;
  late MockUserStateFactory mockUserStateFactory;
  late MockBelongingFactory mockBelongingFactory;

  setUp(() {
    mockInstituteGradeFactory = MockInstituteGradeFactory();
    mockUserStateFactory = MockUserStateFactory();
    mockBelongingFactory = MockBelongingFactory();
    factory = MemberFactory(
        instituteGradeFactory: mockInstituteGradeFactory,
        userStateFactory: mockUserStateFactory,
        belongingFactory: mockBelongingFactory);
  });

  const tMemberId = 'testMemberId';
  const tStudentNumber = 'testStudentNum';
  const tName = 'testName';
  const tInstituteGradeString = 'first';
  final tInstituteGrade = InstituteGrade.values.byName(tInstituteGradeString);
  final tInstituteGradeModel =
      InstituteGradeModel.values.byName(tInstituteGradeString);
  const tUserStateString = 'active';
  final tUserState = UserState.values.byName(tUserStateString);
  final tUserStateModel = UserStateModel.values.byName(tUserStateString);
  const tIsVerified = false;
  const tBelongingParams = BelongingParams(
    id: 'testId',
    type: BelongingType.band,
    name: 'testBelongingName',
  );
  final tBelongingsParams = [tBelongingParams];
  final tBelonging = Band(
    id: tBelongingParams.id,
    name: tBelongingParams.name,
  );
  final tBelongings = [tBelonging];
  final tBelongingModel = BelongingModel(
    id: tBelongingParams.id,
    type: tBelongingParams.type,
    name: tBelongingParams.name,
  );
  final tBelongingModels = [tBelongingModel];
  final tParams = Params(
    memberId: tMemberId,
    studentNumber: tStudentNumber,
    name: tName,
    instituteGrade: tInstituteGradeString,
    userState: tUserStateString,
    isVerified: tIsVerified,
    belongingParams: tBelongingsParams,
  );

  final tValue = Member(
    memberId: tMemberId,
    studentNumber: tStudentNumber,
    name: tName,
    instituteGrade: tInstituteGrade,
    userState: tUserState,
    isVerified: tIsVerified,
    belongings: tBelongings,
  );
  const tAuthModel = FirebaseAuthUserModel(
      email: '$tStudentNumber@photon.chitose.ac.jp',
      studentNumber: tStudentNumber,
      isEmailVerify: tIsVerified);
  final tStoreModel = FirestoreUserModel(
      id: tMemberId,
      studentNumber: tStudentNumber,
      name: tName,
      instituteGrade: tInstituteGradeModel,
      userState: tUserStateModel,
      belongings: tBelongingModels);

  final tModels =
      Models(authUserModel: tAuthModel, storeUserModel: tStoreModel);

  group('create', () {
    test('should return entity', () {
      // arrange
      when(mockInstituteGradeFactory.create(any)).thenReturn(tInstituteGrade);
      when(mockUserStateFactory.create(any)).thenReturn(tUserState);
      when(mockBelongingFactory.create(any)).thenReturn(tBelonging);
      // act
      final result = factory.create(tParams);
      // assert
      expect(result, tValue);
    });
  });

  group('createFromModel', () {
    test('should return entity from model', () {
      // arrange
      when(mockInstituteGradeFactory.createFromModel(any))
          .thenReturn(tInstituteGrade);
      when(mockUserStateFactory.createFromModel(any)).thenReturn(tUserState);
      when(mockBelongingFactory.createFromModel(any)).thenReturn(tBelonging);
      // act
      final result = factory.createFromModel(tModels);
      // assert
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should member model from entity', () {
      // arrange
      when(mockInstituteGradeFactory.convertToModel(any))
          .thenReturn(tInstituteGradeModel);
      when(mockUserStateFactory.convertToModel(any))
          .thenReturn(tUserStateModel);
      when(mockBelongingFactory.convertToModel(any))
          .thenReturn(tBelongingModel);
      // act
      final result = factory.convertToModel(tValue);
      // assert
      expect(
        result,
        isA<Models>()
            .having(
                (models) => models.authUserModel, 'authUserModel', tAuthModel)
            .having((models) => models.storeUserModel, 'storeUserModel',
                tStoreModel),
      );
    });
  });
}
