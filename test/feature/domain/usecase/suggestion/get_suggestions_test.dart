import 'package:cist_keion_app/core/usecases/usecase.dart';
import 'package:cist_keion_app/feature/domain/entity/suggestion/suggestion.dart';
import 'package:cist_keion_app/feature/domain/repository/suggestion_repository.dart';
import 'package:cist_keion_app/feature/domain/usecase/suggestion/get_suggestions.dart';
import 'package:cist_keion_app/feature/domain/value/suggestion_category.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_suggestions_test.mocks.dart';

@GenerateMocks([SuggestionRepository])
void main() {
  late GetSuggestions usecase;
  late MockSuggestionRepository mockSuggestionRepository;

  setUp(() {
    mockSuggestionRepository = MockSuggestionRepository();
    usecase = GetSuggestions(suggestionRepository: mockSuggestionRepository);
  });

  const tSuggestions = [
    Suggestion(
        id: 'testId1',
        description: 'テスト説明1',
        category: SuggestionCategory.club_room),
    Suggestion(
        id: 'testId2',
        description: 'テスト説明2',
        category: SuggestionCategory.live),
  ];

  test('should return result from repository', () async {
    // arrange
    when(mockSuggestionRepository.getAll())
        .thenAnswer((realInvocation) async => const Right(tSuggestions));
    // act
    final result = await usecase(NoParams());
    // assert
    verify(mockSuggestionRepository.getAll());
    expect(result, const Right(tSuggestions));
  });
}
