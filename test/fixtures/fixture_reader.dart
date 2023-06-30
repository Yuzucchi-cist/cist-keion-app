import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

const firestoreUserDataPath = 'auth/firestore_users_data.json';
const firestoreReservationDataPath =
    'reservation/firestore_reservation_data.json';

String fixtureReader(String path) =>
    File('test/fixtures/$path').readAsStringSync();

List<Map<String, dynamic>> firestoreDataReader(
    String path, List<String> firestoreTimestampFieldName) {
  final firestoreJsonData =
      (json.decode(fixtureReader(path)) as List<dynamic>).map((data) {
    final id = (data as Map<String, dynamic>)['id'];
    final value = (data['value'] as Map<String, dynamic>).map<String, dynamic>(
      (key, value) => MapEntry(
        key,
        (firestoreTimestampFieldName.contains(key))
            ? Timestamp.fromDate(DateTime.parse(value as String))
            : value,
      ),
    );
    return {'id': id, 'value': value};
  }).toList();

  return firestoreJsonData;
}
