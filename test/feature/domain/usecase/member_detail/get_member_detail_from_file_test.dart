import 'package:cist_keion_app/core/usecases/usecase.dart';
import 'package:cist_keion_app/feature/domain/entity/member_detail/member_detail.dart';
import 'package:cist_keion_app/feature/domain/repository/member_detail_repository.dart';
import 'package:cist_keion_app/feature/domain/usecase/member_detail/get_member_detail_from_file.dart';
import 'package:cist_keion_app/feature/domain/value/institute_grade.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_member_detail_from_file_test.mocks.dart';

@GenerateMocks([MemberDetailRepository])
void main() {
  late GetMemberDetailFromFile usecase;
  late MockMemberDetailRepository mockMemberDetailRepository;

  setUp(() {
    mockMemberDetailRepository = MockMemberDetailRepository();
    usecase = GetMemberDetailFromFile(
        memberDetailRepository: mockMemberDetailRepository);
  });

  const tMemberDetailList = [
    MemberDetail(
        studentNumber: 'b2202260',
        name: 'testName',
        instituteGrade: InstituteGrade.first)
  ];

  const tResult = (fileName: 'test', data: tMemberDetailList);

  test('should return member detail list from repository', () async {
    // arrange
    when(mockMemberDetailRepository.pickFromFile())
        .thenAnswer((realInvocation) async => const Right(tResult));
    // act
    final result = await usecase(NoParams());
    // assert
    verify(mockMemberDetailRepository.pickFromFile());
    expect(result, const Right(tResult));
  });
}
