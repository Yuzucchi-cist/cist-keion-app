import 'package:cist_keion_app/feature/reservation/data/models/reservation_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tFirestoreJsonData = firestoreDataReader(
      firestoreReservationDataPath, firestoreTimestampFieldName);

  final tId = tFirestoreJsonData.first['id'] as String;
  final tFirestoreDatum =
      tFirestoreJsonData.first['value'] as Map<String, dynamic>;

  final tModel = ReservationModel.fromJson({'id': tId, ...tFirestoreDatum});

  test('should create model from json data', () {
    // act
    final result = ReservationModel.fromFirestoreJson(tId, tFirestoreDatum);
    // assert
    expect(result, tModel);
  });

  test('should should return suitable fire store map from model', () {
    // act
    final result = tModel.toFirestoreJson;
    // assert
    expect(result, tFirestoreDatum);
  });
}
