import 'package:cist_keion_app/feature/data/factory/auth/belonging_factory.dart';
import 'package:cist_keion_app/feature/data/factory/auth/institute_grade_factory.dart';
import 'package:cist_keion_app/feature/data/factory/auth/member_factory.dart';
import 'package:cist_keion_app/feature/data/factory/auth/user_state_factory.dart';
import 'package:cist_keion_app/feature/data/model/auth/authentication/authentication_user_model.dart';
import 'package:cist_keion_app/feature/data/model/auth/member_detail/belonging_model.dart';
import 'package:cist_keion_app/feature/data/model/auth/member_detail/institute_grade_model.dart';
import 'package:cist_keion_app/feature/data/model/auth/member_detail/member_detail_model.dart';
import 'package:cist_keion_app/feature/data/model/auth/member_detail/user_state_model.dart';
import 'package:cist_keion_app/feature/domain/entity/auth/member.dart';
import 'package:cist_keion_app/feature/domain/value/belongings/band.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:cist_keion_app/feature/domain/value/user_state.dart';
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
  const tAuthModel = AuthenticationUserModel(
      email: '$tStudentNumber@photon.chitose.ac.jp',
      studentNumber: tStudentNumber,
      isEmailVerify: tIsVerified);
  final tStoreModel = MemberDetailModel(
      id: tMemberId,
      studentNumber: tStudentNumber,
      name: tName,
      instituteGrade: tInstituteGradeModel,
      userState: tUserStateModel,
      belongings: tBelongingModels);

  final tModels =
      Models(authUserModel: tAuthModel, memberDetailModel: tStoreModel);

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

    test('should return suitable entity when member is admin', () {
      // arrange
      final tModelsIsAdmin = Models(
          authUserModel: tAuthModel,
          memberDetailModel: tStoreModel.copyWith(isAdmin: true));
      final tValueIsAdmin = tValue.copyWith(isAdmin: true);
      when(mockInstituteGradeFactory.createFromModel(any))
          .thenReturn(tInstituteGrade);
      when(mockUserStateFactory.createFromModel(any)).thenReturn(tUserState);
      when(mockBelongingFactory.createFromModel(any)).thenReturn(tBelonging);
      // act
      final result = factory.createFromModel(tModelsIsAdmin);
      // assert
      expect(result, tValueIsAdmin);
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
            .having((models) => models.memberDetailModel, 'storeUserModel',
                tStoreModel),
      );
    });
  });
}
