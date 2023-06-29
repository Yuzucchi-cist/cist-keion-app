import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception/cache_exception.dart';
import '../models/reservation_model.dart';

const cachedReservationsKey = 'CACHED_RESERVATIONS';

abstract class ReservationLocalDataSource {
  Future<void> cacheReservations(List<ReservationModel> models);
  Future<List<ReservationModel>> getReservations();
}

class ReservationLocalDataSourceImpl implements ReservationLocalDataSource {
  ReservationLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<void> cacheReservations(List<ReservationModel> models) async {
    final modelMap = models
        .map((model) => model.toJson().map((key, value) => MapEntry(key,
            value is Timestamp ? value.toDate().toIso8601String() : value)))
        .toList();
    sharedPreferences.setString(cachedReservationsKey, json.encode(modelMap));
  }

  @override
  Future<List<ReservationModel>> getReservations() async {
    final jsonString = sharedPreferences.getString(cachedReservationsKey);
    if (jsonString == null) {
      throw CacheException();
    }
    final jsonMap = json.decode(jsonString) as List<dynamic>;
    return jsonMap.map((reservationJson) {
      final convertedJson = (reservationJson as Map<String, dynamic>).map(
          (key, value) => MapEntry(
              key,
              firestoreTimestampFieldName.contains(key)
                  ? Timestamp.fromDate(DateTime.parse(value as String))
                  : value));
      return ReservationModel.fromJson(convertedJson);
    }).toList();
  }
}
