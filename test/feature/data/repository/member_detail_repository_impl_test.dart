import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/core/error/exception/picking_file_exception.dart';
import 'package:cist_keion_app/core/error/failure/member_detail/member_detail_failure.dart';
import 'package:cist_keion_app/core/error/failure/member_detail/member_detail_failure_state.dart';
import 'package:cist_keion_app/core/error/failure/remote_data/remote_data_failure.dart';
import 'package:cist_keion_app/core/error/failure/remote_data/remote_data_failure_state.dart';
import 'package:cist_keion_app/core/error/failure/server/server_failure.dart';
import 'package:cist_keion_app/core/network/network_info.dart';
import 'package:cist_keion_app/feature/data/datasource/member_detail_local_data_source.dart';
import 'package:cist_keion_app/feature/data/datasource/member_detail_remote_data_source.dart';
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

@GenerateMocks([
  NetworkInfo,
  MemberDetailLocalDataSource,
  MemberDetailRemoteDataSource,
  MemberDetailFactory,
])
void main() {
  late MemberDetailRepositoryImpl repository;
  late MockNetworkInfo mockNetworkInfo;
  late MockMemberDetailLocalDataSource mockMemberDetailLocalDataSource;
  late MockMemberDetailRemoteDataSource mockMemberDetailRemoteDataSource;
  late MockMemberDetailFactory mockMemberDetailFactory;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockMemberDetailLocalDataSource = MockMemberDetailLocalDataSource();
    mockMemberDetailRemoteDataSource = MockMemberDetailRemoteDataSource();
    mockMemberDetailFactory = MockMemberDetailFactory();
    repository = MemberDetailRepositoryImpl(
        networkInfo: mockNetworkInfo,
        memberDetailLLocalDataSource: mockMemberDetailLocalDataSource,
        memberDetailRemoteDataSource: mockMemberDetailRemoteDataSource,
        memberDetailFactory: mockMemberDetailFactory);
  });

  void checkOnline(
      {required void Function() arrange, required void Function() act}) {
    test('should check online', () async {
      // arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      arrange();
      // act
      act();
      // assert
      verify(mockNetworkInfo.isConnected);
    });
  }

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

  group('getAll', () {
    checkOnline(
      arrange: () {
        when(mockMemberDetailRemoteDataSource.getAll())
            .thenAnswer((realInvocation) async => tMemberDetailModelList);
        tMemberDetailModelList.asMap().forEach((i, memberDetailModel) =>
            when(mockMemberDetailFactory.createFromModel(memberDetailModel))
                .thenReturn(tMemberDetailList.elementAt(i)));
      },
      act: () => repository.getAll(),
    );

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should return member detail list when datasource is successful',
          () async {
        // arrange
        when(mockMemberDetailRemoteDataSource.getAll())
            .thenAnswer((realInvocation) async => tMemberDetailModelList);
        tMemberDetailModelList.asMap().forEach((i, memberDetailModel) =>
            when(mockMemberDetailFactory.createFromModel(memberDetailModel))
                .thenReturn(tMemberDetailList.elementAt(i)));
        // act
        final result = (await repository.getAll()).fold((l) => l, (r) => r);
        // assert
        verify(mockMemberDetailRemoteDataSource.getAll());
        expect(result, unorderedEquals(tMemberDetailList));
      });

      test('should return member detail failure when datasource failed',
          () async {
        // arrange
        when(mockMemberDetailRemoteDataSource.getAll())
            .thenThrow(FirestoreException('no-data'));
        // act
        final result = await repository.getAll();
        // assert
        expect(result, Left(RemoteDataFailure(RemoteDataFailureState.noData)));
      });
    });

    group('device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false));

      test('should return server failure', () async {
        // act
        final result = await repository.getAll();
        // assert
        expect(result, Left(ServerFailure()));
      });
    });
  });

  group('addToDatabase', () {
    checkOnline(
      arrange: () {
        when(mockMemberDetailRemoteDataSource.add(any))
            .thenAnswer((realInvocation) async => tMemberDetailModelList);
        tMemberDetailList.asMap().forEach((i, memberDetail) {
          final memberDetailModel = tMemberDetailModelList.elementAt(i);
          when(mockMemberDetailFactory.convertToModel(memberDetail))
              .thenReturn(memberDetailModel);
          when(mockMemberDetailFactory.createFromModel(memberDetailModel))
              .thenAnswer((realInvocation) => memberDetail);
        });
      },
      act: () => repository.addToDatabase(tMemberDetailList),
    );

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should call remote data source to add data', () async {
        // arrange
        when(mockMemberDetailRemoteDataSource.add(any))
            .thenAnswer((realInvocation) async => tMemberDetailModelList);
        tMemberDetailList.asMap().forEach((i, memberDetail) {
          final memberDetailModel = tMemberDetailModelList.elementAt(i);
          when(mockMemberDetailFactory.convertToModel(memberDetail))
              .thenReturn(memberDetailModel);
          when(mockMemberDetailFactory.createFromModel(memberDetailModel))
              .thenAnswer((realInvocation) => memberDetail);
        });
        // act
        final result = (await repository.addToDatabase(tMemberDetailList))
            .fold((l) => l, (r) => r);
        // assert
        verify(mockMemberDetailRemoteDataSource.add(tMemberDetailModelList));
        expect(result, unorderedEquals(tMemberDetailList));
      });

      test('should return firestore failure when datasource failed', () async {
        // arrange
        tMemberDetailList.asMap().forEach((i, memberDetail) =>
            when(mockMemberDetailFactory.convertToModel(memberDetail))
                .thenReturn(tMemberDetailModelList.elementAt(i)));
        when(mockMemberDetailRemoteDataSource.add(any))
            .thenThrow(FirestoreException('no-data'));
        // act
        final result = await repository.addToDatabase(tMemberDetailList);
        // assert
        expect(result, Left(RemoteDataFailure(RemoteDataFailureState.noData)));
      });
    });

    group('device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false));

      test('should return server failure', () async {
        // act
        final result = await repository.addToDatabase(tMemberDetailList);
        // assert
        expect(result, Left(ServerFailure()));
      });
    });
  });
}
