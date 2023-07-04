import '../../../../core/factories/data_factory.dart';
import '../../domain/values/suggestion_category.dart';

class SuggestionCategoryFactory
    implements DataFactory<SuggestionCategory, String, String> {
  @override
  String convertToModel(SuggestionCategory entity) {
    return entity.name;
  }

  @override
  SuggestionCategory create(String param) {
    return SuggestionCategory.values.byName(param);
  }

  @override
  SuggestionCategory createFromModel(String model) {
    return SuggestionCategory.values.byName(model);
  }
}
