import 'package:cist_keion_app/feature/suggestion/data/factories/suggestion_category_factory.dart';
import 'package:cist_keion_app/feature/suggestion/data/factories/suggestion_factory.dart';
import 'package:cist_keion_app/feature/suggestion/data/models/suggestion_model.dart';
import 'package:cist_keion_app/feature/suggestion/domain/entities/suggestion.dart';
import 'package:cist_keion_app/feature/suggestion/domain/values/suggestion_category.dart';
import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'suggestion_factory_test.mocks.dart';

@GenerateMocks([SuggestionCategoryFactory])
void main() {
  late SuggestionFactory factory;
  late MockSuggestionCategoryFactory mockSuggestionCategoryFactory;

  setUp(() {
    mockSuggestionCategoryFactory = MockSuggestionCategoryFactory();
    factory = SuggestionFactory(
        suggestionCategoryFactory: mockSuggestionCategoryFactory);
  });

  final tValue = Suggestion(
      id: 'testId',
      description: 'テストです。',
      category: SuggestionCategory.club_room,
      createdAt: DateTime(2023, 07, 04));

  final tModel = SuggestionModel(
      id: 'testId',
      description: tValue.description,
      category: tValue.category.name,
      createdAt: Timestamp.fromDate(tValue.createdAt!));

  final params = Params(
      description: 'テストです。',
      category: 'club_room',
      createdAt: DateTime(2023, 07, 04));

  group('create', () {
    test('should return suggestion', () {
      // arrange
      final tValueWithEmptyId = tValue.copyWith(id: '');
      when(mockSuggestionCategoryFactory.create(any))
          .thenAnswer((realInvocation) => tValue.category);
      // act
      final result = factory.create(params);
      // assert
      verify(mockSuggestionCategoryFactory.create(params.category));
      expect(result, tValueWithEmptyId);
    });
  });

  group('createFromModel', () {
    test('should return member', () {
      // arrange
      when(mockSuggestionCategoryFactory.createFromModel(any))
          .thenAnswer((realInvocation) => tValue.category);
      // act
      final result = factory.createFromModel(tModel);
      // assert
      verify(mockSuggestionCategoryFactory.createFromModel(tModel.category));
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should return model', () {
      // arrange
      when(mockSuggestionCategoryFactory.convertToModel(any))
          .thenAnswer((realInvocation) => tModel.category);
      // act
      final result = factory.convertToModel(tValue);
      // assert
      verify(mockSuggestionCategoryFactory.convertToModel(tValue.category));
      expect(result, tModel);
    });

    test(
        'should return model with time stamp when createdAt or updatedAt is null',
        () {
      final tNow = DateTime(2023, 07, 07, 18, 30);
      withClock(Clock.fixed(tNow), () {
        // arrange
        final tValueWithNull = tValue.copyWith(createdAt: null);
        final tModelWithTimestamp =
            tModel.copyWith(createdAt: Timestamp.fromDate(clock.now()));
        when(mockSuggestionCategoryFactory.convertToModel(any))
            .thenAnswer((realInvocation) => tModel.category);
        // act
        final result = factory.convertToModel(tValueWithNull);
        // assert
        expect(result, tModelWithTimestamp);
      });
    });
  });
}
