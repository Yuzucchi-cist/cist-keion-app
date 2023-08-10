import 'package:cist_keion_app/core/error/exception/firestore_exception.dart';
import 'package:cist_keion_app/core/error/failure/server/server_failure.dart';
import 'package:cist_keion_app/core/error/failure/suggestion/suggestion_failure.dart';
import 'package:cist_keion_app/core/error/failure/suggestion/suggestion_failure_state.dart';
import 'package:cist_keion_app/core/network/network_info.dart';
import 'package:cist_keion_app/feature/data/datasource/suggestion_data_source.dart';
import 'package:cist_keion_app/feature/data/factory/suggestion/suggestion_factory.dart';
import 'package:cist_keion_app/feature/data/model/suggestion/suggestion_model.dart';
import 'package:cist_keion_app/feature/data/repository/suggestion_repository_impl.dart';
import 'package:cist_keion_app/feature/domain/entity/suggestion/suggestion.dart';
import 'package:cist_keion_app/feature/domain/value/suggestion_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'suggestion_repository_impl_test.mocks.dart';

@GenerateMocks([SuggestionDataSource, NetworkInfo, SuggestionFactory])
void main() {
  late SuggestionRepositoryImpl repository;
  late MockSuggestionDataSource mockSuggestionDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockSuggestionFactory mockSuggestionFactory;

  setUp(() {
    mockSuggestionDataSource = MockSuggestionDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockSuggestionFactory = MockSuggestionFactory();
    repository = SuggestionRepositoryImpl(
      suggestionDataSource: mockSuggestionDataSource,
      networkInfo: mockNetworkInfo,
      suggestionFactory: mockSuggestionFactory,
    );
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

  const tSuggestion = Suggestion(
      id: '', description: 'テストです。', category: SuggestionCategory.club_room);
  final tSuggestionModel = SuggestionModel(
    id: '',
    description: tSuggestion.description,
    category: tSuggestion.category.name,
    createdAt: Timestamp.fromDate(DateTime(2023, 07, 07)),
  );

  const tSuggestionList = [
    Suggestion(
        id: '', description: 'テスト1です。', category: SuggestionCategory.club_room),
    Suggestion(
        id: '', description: 'テスト2です。', category: SuggestionCategory.live),
  ];
  final tSuggestionModelList = tSuggestionList
      .map((suggestion) => SuggestionModel(
            id: 'testId',
            description: suggestion.description,
            category: suggestion.category.name,
            createdAt: Timestamp.fromDate(DateTime(2023, 07, 07)),
          ))
      .toList();

  group('add', () {
    checkOnline(
      arrange: () {
        when(mockSuggestionFactory.convertToModel(any))
            .thenReturn(tSuggestionModel);
        when(mockSuggestionDataSource.add(any))
            .thenAnswer((realInvocation) async {});
      },
      act: () {
        repository.add(tSuggestion);
      },
    );

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));

      test('should return unit(void) when data source is successful', () async {
        // arrange
        when(mockSuggestionFactory.convertToModel(any))
            .thenReturn(tSuggestionModel);
        when(mockSuggestionDataSource.add(any))
            .thenAnswer((realInvocation) async {});
        // act
        final result = await repository.add(tSuggestion);
        // assert
        verify(mockSuggestionDataSource.add(tSuggestionModel));
        verify(mockSuggestionFactory.convertToModel(tSuggestion));
        expect(result, const Right(unit));
      });

      test('should return firestore failure when datasource failed', () async {
        // arrange
        when(mockSuggestionFactory.convertToModel(any))
            .thenReturn(tSuggestionModel);
        when(mockSuggestionDataSource.add(any))
            .thenThrow(FirestoreException('no-data'));
        // act
        final result = await repository.add(tSuggestion);
        // assert
        expect(result, Left(SuggestionFailure(SuggestionFailureState.noData)));
      });
    });

    group('device is offline', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false));

      test('should return server failure', () async {
        // act
        final result = await repository.add(tSuggestion);
        // assert
        expect(result, Left(ServerFailure()));
      });
    });
  });

  group('getAll', () {
    checkOnline(
      arrange: () {
        when(mockSuggestionDataSource.getAll())
            .thenAnswer((realInvocation) async => tSuggestionModelList);
        tSuggestionModelList.asMap().forEach((index, model) {
          when(mockSuggestionFactory.createFromModel(model))
              .thenReturn(tSuggestionList.elementAt(index));
        });
      },
      act: () {
        repository.getAll();
      },
    );

    group('device is online', () {
      setUp(() => when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true));
      test('should return suggestion list when data source is successful',
          () async {
        // arrange
        when(mockSuggestionDataSource.getAll())
            .thenAnswer((realInvocation) async => tSuggestionModelList);
        tSuggestionModelList.asMap().forEach((index, model) {
          when(mockSuggestionFactory.createFromModel(model))
              .thenReturn(tSuggestionList.elementAt(index));
        });
        // act
        final result = (await repository.getAll()).fold((l) => l, (r) => r);
        // assert
        verify(mockSuggestionDataSource.getAll());
        expect(result, unorderedEquals(tSuggestionList));
      });

      test('should return firestore failure when datasource failed', () async {
        // arrange
        when(mockSuggestionDataSource.getAll())
            .thenThrow(FirestoreException('no-data'));
        // act
        final result = await repository.getAll();
        // assert
        expect(result, Left(SuggestionFailure(SuggestionFailureState.noData)));
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
}
