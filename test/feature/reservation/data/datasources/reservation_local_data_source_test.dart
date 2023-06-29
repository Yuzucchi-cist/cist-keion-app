import 'dart:convert';

import 'package:cist_keion_app/core/error/exception/cache_exception.dart';
import 'package:cist_keion_app/feature/reservation/data/datasources/reservation_local_data_source.dart';
import 'package:cist_keion_app/feature/reservation/data/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'reservation_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ReservationLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ReservationLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  final firestoreJson = firestoreDataReader(
      firestoreReservationDataPath, firestoreTimestampFieldName);
  final firestoreJsonString = firestoreJson
      .map((e) => {
            'id': e['id'],
            ...(e['value'] as Map<String, dynamic>).map((key, value) =>
                MapEntry(
                    key,
                    value is Timestamp
                        ? value.toDate().toIso8601String()
                        : value))
          })
      .toList();

  final tReservationModelList = firestoreJson
      .map((e) => ReservationModel.fromFirestoreJson(
          e['id'] as String, e['value'] as Map<String, dynamic>))
      .toList();

  group('getLastReservations', () {
    test('should return models from shared preferences when cache exists',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(json.encode(firestoreJsonString));
      // act
      final result = await dataSource.getReservations();
      // assert
      verify(mockSharedPreferences.getString(cachedReservationsKey));
      expect(result, unorderedEquals(tReservationModelList));
    });

    test('キャッシュにデータが存在しない場合、CacheException を投げる.', () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getReservations;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    test('キャッシュに保存するときに、SharedPreferences を呼び出す', () async {
      // arrange
      final expectedJsonString = json.encode(firestoreJsonString);
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      await dataSource.cacheReservations(tReservationModelList);
      // assert
      verify(mockSharedPreferences.setString(
          cachedReservationsKey, expectedJsonString));
    });
  });
}
