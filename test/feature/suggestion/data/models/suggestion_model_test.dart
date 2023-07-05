import 'package:cist_keion_app/feature/suggestion/data/models/suggestion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tFirestoreData =
      firestoreDataReader(firestoreSuggestionDataPath, ['created_at'])
          .first['value'] as Map<String, dynamic>;

  final tModel = SuggestionModel(
      description: tFirestoreData['description'] as String,
      category: tFirestoreData['category'] as String,
      createdAt: tFirestoreData['created_at'] as Timestamp);

  test('should create model from json data', () {
    // act
    final result = SuggestionModel.fromJson(tFirestoreData);
    // assert
    expect(result, tModel);
  });

  test('should should return suitable fire store map from model', () {
    // act
    final result = tModel.toJson();
    // assert
    expect(result, tFirestoreData);
  });
}
