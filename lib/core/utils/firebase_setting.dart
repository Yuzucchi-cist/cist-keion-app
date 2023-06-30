import 'package:firebase_core/firebase_core.dart';

import '../firebase_options/firebase_options_dev.dart' as firebase_options_dev;
import '../firebase_options/firebase_options_prod.dart'
    as firebase_options_prod;
import '../firebase_options/firebase_options_stg.dart' as firebase_options_stg;

const flavorString = String.fromEnvironment('flavor');

final flavor = Flavor.values.firstWhere(
  (flavor) => flavor.name == flavorString,
  orElse: () => Flavor.dev,
);

enum Flavor {
  dev,
  stg,
  prod;

  const Flavor();

  FirebaseOptions get firebaseOptions {
    switch (this) {
      case dev:
        return firebase_options_dev.DefaultFirebaseOptions.currentPlatform;
      case stg:
        return firebase_options_stg.DefaultFirebaseOptions.currentPlatform;
      case prod:
        return firebase_options_prod.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
