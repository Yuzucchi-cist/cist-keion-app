import 'package:cist_keion_app/feature/data/factory/member_detail/belonging_factory.dart';
import 'package:cist_keion_app/feature/data/factory/member_detail/institute_grade_factory.dart';
import 'package:cist_keion_app/feature/data/factory/member_detail/member_detail_factory.dart';
import 'package:cist_keion_app/feature/data/factory/member_detail/user_state_factory.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/belonging_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/institute_grade_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/member_detail_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/user_state_model.dart';
import 'package:cist_keion_app/feature/domain/entity/member_detail/member_detail.dart';
import 'package:cist_keion_app/feature/domain/value/belongings/band.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:cist_keion_app/feature/domain/value/user_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../auth/member_factory_test.mocks.dart';

@GenerateMocks([InstituteGradeFactory, UserStateFactory, BelongingFactory])
void main() {
  late MemberDetailFactory factory;
  late MockInstituteGradeFactory mockInstituteGradeFactory;
  late MockUserStateFactory mockUserStateFactory;
  late MockBelongingFactory mockBelongingFactory;

  setUp(() {
    mockInstituteGradeFactory = MockInstituteGradeFactory();
    mockUserStateFactory = MockUserStateFactory();
    mockBelongingFactory = MockBelongingFactory();
    factory = MemberDetailFactory(
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
  const tIsAdmin = false;
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

  final tParams = MemberDetailParams(
    id: tMemberId,
    studentNumber: tStudentNumber,
    name: tName,
    instituteGrade: tInstituteGradeString,
    userState: tUserStateString,
    isAdmin: tIsAdmin,
    belongingParams: tBelongingsParams,
  );

  final tValue = MemberDetail(
    id: tMemberId,
    studentNumber: tStudentNumber,
    name: tParams.name,
    instituteGrade: tInstituteGrade,
    userState: tUserState,
    belongings: tBelongings,
  );

  final tModel = MemberDetailModel(
    id: tMemberId,
    studentNumber: tStudentNumber,
    name: tParams.name,
    instituteGrade: tInstituteGradeModel,
    userState: tUserStateModel,
    belongings: tBelongingModels,
  );

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
      final result = factory.createFromModel(tModel);
      // assert
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should return model from entity', () {
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
      expect(result, tModel);
    });
  });
}
