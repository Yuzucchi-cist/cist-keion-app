import 'package:cist_keion_app/feature/suggestion/domain/entities/suggestion.dart';
import 'package:cist_keion_app/feature/suggestion/domain/repositories/suggestion_repository.dart';
import 'package:cist_keion_app/feature/suggestion/domain/usecases/add_suggestion.dart';
import 'package:cist_keion_app/feature/suggestion/domain/values/suggestion_category.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_suggestion_test.mocks.dart';

@GenerateMocks([SuggestionRepository])
void main() {
  late AddSuggestion usecase;
  late MockSuggestionRepository mockSuggestionRepository;

  setUp(() {
    mockSuggestionRepository = MockSuggestionRepository();
    usecase = AddSuggestion(suggestionRepository: mockSuggestionRepository);
  });

  final tParams = AddSuggestionParams(
      description: 'テストです。', category: SuggestionCategory.club_room);
  final tSuggestion = Suggestion(
      id: '', description: tParams.description, category: tParams.category);

  test('should return result from repository', () async {
    // arrange
    when(mockSuggestionRepository.add(any))
        .thenAnswer((realInvocation) async => const Right(unit));
    // act
    final result = await usecase(tParams);
    // assert
    verify(mockSuggestionRepository.add(tSuggestion));
    expect(result, const Right(unit));
  });
}
