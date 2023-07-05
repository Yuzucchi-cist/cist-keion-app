import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/factories/data_factory.dart';
import '../../domain/entities/suggestion.dart';
import '../models/suggestion_model.dart';
import 'suggestion_category_factory.dart';

class SuggestionFactory
    implements DataFactory<Suggestion, SuggestionModel, Params> {
  SuggestionFactory({required this.suggestionCategoryFactory});

  final SuggestionCategoryFactory suggestionCategoryFactory;

  @override
  SuggestionModel convertToModel(Suggestion entity) {
    return SuggestionModel(
        description: entity.description,
        category: suggestionCategoryFactory.convertToModel(entity.category),
        createdAt: entity.createdAt != null
            ? Timestamp.fromDate(entity.createdAt!)
            : null);
  }

  @override
  Suggestion create(Params params) {
    return Suggestion(
        description: params.description,
        category: suggestionCategoryFactory.create(params.category),
        createdAt: params.createdAt);
  }

  @override
  Suggestion createFromModel(SuggestionModel model) {
    return Suggestion(
        description: model.description,
        category: suggestionCategoryFactory.createFromModel(model.category),
        createdAt: model.createdAt?.toDate());
  }
}

class Params {
  Params({
    required this.description,
    required this.category,
    required this.createdAt,
  });

  final String description;
  final String category;
  final DateTime createdAt;
}
