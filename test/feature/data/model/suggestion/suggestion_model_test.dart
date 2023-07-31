import 'package:cist_keion_app/feature/data/model/suggestion/suggestion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tFirestoreData =
      firestoreDataReader(firestoreSuggestionDataPath, ['created_at']).first;

  final tId = tFirestoreData['id'] as String;
  final tFirestoreJson = tFirestoreData['value'] as Map<String, dynamic>;

  final tModel = SuggestionModel(
      id: tId,
      description: tFirestoreJson['description'] as String,
      category: tFirestoreJson['category'] as String,
      createdAt: tFirestoreJson['created_at'] as Timestamp);

  test('should create model from json data', () {
    // act
    final result = SuggestionModel.fromFirestoreJson(tId, tFirestoreJson);
    // assert
    expect(result, tModel);
  });

  test('should should return suitable fire store map from model', () {
    // act
    final result = tModel.toFirestoreJson;
    // assert
    expect(result, tFirestoreJson);
  });
}
