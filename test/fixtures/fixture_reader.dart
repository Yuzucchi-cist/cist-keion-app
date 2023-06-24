import 'dart:io';

const firestoreUserDataPath = 'auth/firestore_users_data.json';

String fixtureReader(String path) =>
    File('test/fixtures/$path').readAsStringSync();
