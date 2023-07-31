import 'package:cist_keion_app/feature/data/datasource/suggestion_remote_data_source.dart';
import 'package:cist_keion_app/feature/data/model/suggestion/suggestion_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  late SuggestionRemoteDataSourceImpl dataSource;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    dataSource = SuggestionRemoteDataSourceImpl(firestore: mockFirestore);
  });

  final tFirestoreData =
      firestoreDataReader(firestoreSuggestionDataPath, ['created_at']).toList();
  final tFirestoreJson = tFirestoreData.map((data) {
    final id = data['id'];
    final value = data['value'] as Map<String, dynamic>;
    return {'id': id, ...value};
  }).toList();

  final tModels =
      tFirestoreJson.map((json) => SuggestionModel.fromJson(json)).toList();

  final tModel = tModels.first;

  group('add', () {
    test('should call firestore add', () async {
      // act
      await dataSource.add(tModel);
      // assert
      final result =
          (await mockFirestore.collection(suggestionCollectionName).get())
              .docs
              .map((doc) => doc.data());
      expect(result, [tModel.toFirestoreJson]);
    });
  });

  group('getAll', () {
    test('should return models', () async {
      // arrange
      for (final data in tFirestoreData) {
        mockFirestore
            .collection(suggestionCollectionName)
            .doc(data['id'] as String)
            .set(data['value'] as Map<String, dynamic>);
      }
      // act
      final result = await dataSource.getAll();
      // assert
      expect(result, unorderedEquals(tModels));
    });
  });
}
