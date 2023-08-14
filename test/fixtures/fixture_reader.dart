import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

const firestoreUserDataPath = 'auth/firestore_users_data.json';
const firestoreReservationDataPath =
    'reservation/firestore_reservation_data.json';
const firestoreSuggestionDataPath = 'suggestion/firestore_suggestion_data.json';
const excelMemberDetailPath = 'member_detail/excel_member_detail_data.xlsx';
const excelIllegalTableFormatMemberDetailPath =
    'member_detail/illegal_table_format_data.xlsx';
const txtillegalFileTypeMemberDetailPath =
    'member_detail/illegal_file_type_data.txt';
const jsonMemberDetailData = 'member_detail/json_member_detail_data.json';

String fixtureReader(String path) =>
    File('test/fixtures/$path').readAsStringSync();

List<Map<String, dynamic>> firestoreDataReader(
    String path, List<String> firestoreTimestampFieldNames) {
  final firestoreJsonData =
      (json.decode(fixtureReader(path)) as List<dynamic>).map((data) {
    final id = (data as Map<String, dynamic>)['id'];
    final value = (data['value'] as Map<String, dynamic>).map<String, dynamic>(
      (key, value) => MapEntry(
        key,
        (firestoreTimestampFieldNames.contains(key))
            ? Timestamp.fromDate(DateTime.parse(value as String))
            : value,
      ),
    );
    return {'id': id, 'value': value};
  }).toList();

  return firestoreJsonData;
}

Uint8List bytesReader(String path) =>
    File('test/fixtures/$path').readAsBytesSync();
