import 'package:cist_keion_app/feature/data/factory/suggestion/suggestion_category_factory.dart';
import 'package:cist_keion_app/feature/domain/value/suggestion_category.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SuggestionCategoryFactory factory;

  setUp(() => factory = SuggestionCategoryFactory());

  const tValue = SuggestionCategory.club_room;
  const tModel = 'club_room';

  group('create', () {
    test('should return suggestion category', () {
      // act
      final result = factory.create('club_room');
      // assert
      expect(result, tValue);
    });
  });

  group('createFromModel', () {
    test('should return member', () {
      // act
      final result = factory.createFromModel(tModel);
      // assert
      expect(result, tValue);
    });
  });

  group('convertToModel', () {
    test('should return model', () {
      // act
      final result = factory.convertToModel(tValue);
      // assert
      expect(result, tModel);
    });
  });
}
