import 'package:cist_keion_app/feature/suggestion/data/datasources/suggestion_remote_data_source.dart';
import 'package:cist_keion_app/feature/suggestion/data/models/suggestion_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  late SuggestionRemoteDataSourceImpl dataSource;
  late FakeFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    dataSource = SuggestionRemoteDataSourceImpl(firestore: mockFirestore);
  });

  const tModel = SuggestionModel(description: 'テストです。', category: 'club_room');

  group('add', () {
    test('should call firestore add', () async {
      // act
      await dataSource.add(tModel);
      // assert
      final result =
          (await mockFirestore.collection(suggestionCollectionName).get())
              .docs
              .map((doc) => doc.data());
      expect(result, [tModel.toJson()]);
    });
  });
}
