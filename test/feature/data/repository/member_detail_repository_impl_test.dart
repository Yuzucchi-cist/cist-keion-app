import 'package:cist_keion_app/core/error/exception/picking_file_exception.dart';
import 'package:cist_keion_app/core/error/failure/member_detail/member_detail_failure.dart';
import 'package:cist_keion_app/core/error/failure/member_detail/member_detail_failure_state.dart';
import 'package:cist_keion_app/feature/data/datasource/member_detail_local_data_source.dart';
import 'package:cist_keion_app/feature/data/factory/member_detail/member_detail_factory.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/institute_grade_model.dart';
import 'package:cist_keion_app/feature/data/model/member_detail/member_detail_model.dart';
import 'package:cist_keion_app/feature/data/repository/member_detail_repository_impl.dart';
import 'package:cist_keion_app/feature/domain/entity/member_detail/member_detail.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'member_detail_repository_impl_test.mocks.dart';

@GenerateMocks([MemberDetailLocalDataSource, MemberDetailFactory])
void main() {
  late MemberDetailRepositoryImpl repository;
  late MockMemberDetailLocalDataSource mockMemberDetailLocalDataSource;
  late MockMemberDetailFactory mockMemberDetailFactory;

  setUp(() {
    mockMemberDetailLocalDataSource = MockMemberDetailLocalDataSource();
    mockMemberDetailFactory = MockMemberDetailFactory();
    repository = MemberDetailRepositoryImpl(
        memberDetailLLocalDataSource: mockMemberDetailLocalDataSource,
        memberDetailFactory: mockMemberDetailFactory);
  });

  const tStudentNumber = 'testStudentNum';
  const tName = 'testName';
  const tInstituteGradeString = 'first';
  final tInstituteGrade = InstituteGrade.values.byName(tInstituteGradeString);
  final tInstituteGradeModel =
      InstituteGradeModel.values.byName(tInstituteGradeString);
  const tIsAdmin = true;

  final tMemberDetail = MemberDetail(
    studentNumber: tStudentNumber,
    name: tName,
    instituteGrade: tInstituteGrade,
    isAdmin: tIsAdmin,
  );

  final tMemberDetailModel = MemberDetailModel(
    studentNumber: tStudentNumber,
    name: tName,
    instituteGrade: tInstituteGradeModel,
    isAdmin: tIsAdmin,
  );

  const tFileName = 'test.xlsx';

  final tMemberDetailList = [tMemberDetail];
  final tMemberDetailModelList = [tMemberDetailModel];

  group('pickFromFile', () {
    test('should return member detail List when data source is successfull',
        () async {
      // arrange
      when(mockMemberDetailLocalDataSource.pickFromLocalFile()).thenAnswer(
          (realInvocation) async => (tFileName, tMemberDetailModelList));
      tMemberDetailModelList.asMap().forEach((i, model) =>
          when(mockMemberDetailFactory.createFromModel(model))
              .thenReturn(tMemberDetailList.elementAt(i)));
      // act
      final result =
          (await repository.pickFromFile()).fold((l) => null, (r) => r);
      // assert
      verify(mockMemberDetailLocalDataSource.pickFromLocalFile());
      expect(result?.fileName, tFileName);
      expect(result?.data, unorderedEquals(tMemberDetailList));
    });

    test('should return the member detail failure when the data source failed',
        () async {
      // arrange
      when(mockMemberDetailLocalDataSource.pickFromLocalFile()).thenThrow(
          PickingFileException(
              code: 'no-file', message: 'ERROR: No File Selected'));
      // act
      final result = await repository.pickFromFile();
      // assert
      expect(
          result, Left(MemberDetailFailure(MemberDetailFailureState.noFile)));
    });
  });
}
