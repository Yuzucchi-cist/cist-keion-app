import 'package:cist_keion_app/core/error/failure/failure.dart';
import 'package:cist_keion_app/core/error/failure/server/server_failure.dart';
import 'package:cist_keion_app/feature/domain/entity/member_detail/member_detail.dart';
import 'package:cist_keion_app/feature/domain/repository/member_detail_repository.dart';
import 'package:cist_keion_app/feature/domain/usecase/member_detail/add_member_detail_to_database.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_member_detail_from_file_test.mocks.dart';

@GenerateMocks([MemberDetailRepository])
void main() {
  late AddMemberDetailToDatabase usecase;
  late MockMemberDetailRepository mockMemberDetailRepository;

  setUp(() {
    mockMemberDetailRepository = MockMemberDetailRepository();
    usecase = AddMemberDetailToDatabase(
        memberDetailRepository: mockMemberDetailRepository);
  });

  final tMemberDetailList = [
    const MemberDetail(
      studentNumber: 'b2202260',
      name: 'testName',
      instituteGrade: InstituteGrade.first,
    ),
    const MemberDetail(
      studentNumber: 'b2202130',
      name: 'testName2',
      instituteGrade: InstituteGrade.second,
    ),
  ];

  test('should return member detail list from repository', () async {
    // arrange
    when(mockMemberDetailRepository.addToDatabase(any))
        .thenAnswer((realInvocation) async => Right(tMemberDetailList));
    when(mockMemberDetailRepository.getAll())
        .thenAnswer((realInvocation) async => const Right([]));
    // act
    final result = await usecase(tMemberDetailList);
    // assert
    verify(mockMemberDetailRepository.addToDatabase(tMemberDetailList));
    expect(result, Right(tMemberDetailList));
  });

  final tAlreadyExistsMemberDetailList = [
    MemberDetail(
        studentNumber: tMemberDetailList.first.studentNumber,
        name: 'testName2',
        instituteGrade: InstituteGrade.second)
  ];
  final tAddingMemberDetailList = [...tMemberDetailList]..removeWhere(
      (element) => tAlreadyExistsMemberDetailList
          .map((element) => element.studentNumber)
          .contains(element.studentNumber));

  test('should exclude the data already exists in database', () async {
    // arrange
    when(mockMemberDetailRepository.addToDatabase(any))
        .thenAnswer((realInvocation) async => Right(tAddingMemberDetailList));
    when(mockMemberDetailRepository.getAll()).thenAnswer(
        (realInvocation) async => Right(tAlreadyExistsMemberDetailList));
    // act
    await usecase(tMemberDetailList);
    // assert
    verify(mockMemberDetailRepository.addToDatabase(tAddingMemberDetailList));
  });

  final tDuplicatedMemberDetailList = [
    tMemberDetailList.first,
    ...tMemberDetailList,
  ];

  test('should exclude the duplicate data', () async {
    // arrange
    when(mockMemberDetailRepository.addToDatabase(any))
        .thenAnswer((realInvocation) async => Right(tMemberDetailList));
    when(mockMemberDetailRepository.getAll())
        .thenAnswer((realInvocation) async => const Right([]));
    // act
    await usecase(tDuplicatedMemberDetailList);
    // assert
    verify(mockMemberDetailRepository.addToDatabase(tMemberDetailList));
  });

  test('should return empty list when data is empty', () async {
    // arrange
    when(mockMemberDetailRepository.getAll())
        .thenAnswer((realInvocation) async => Right(tMemberDetailList));
    // act
    final result = await usecase([]);
    // assert
    expect(result, const Right<Failure, List<MemberDetail>>([]));
  });

  test('should return failure when getting member detail failed', () async {
    // arrange
    when(mockMemberDetailRepository.getAll())
        .thenAnswer((realInvocation) async => Left(ServerFailure()));
    // act
    final result = await usecase(tMemberDetailList);
    // assert
    expect(result, Left(ServerFailure()));
  });
}

/*
belongings
institute_grade
"other"
is_admin
false
name
"三浦 章子"
student_number
"b1904230"
user_state
"active"
 */
