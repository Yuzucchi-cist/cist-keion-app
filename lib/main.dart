import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/firebase_options/firebase_options_dev.dart' as dev_firebase_option;
import 'core/firebase_options/firebase_options_prod.dart'
    as prod_firebase_option;
import 'core/firebase_options/firebase_options_stg.dart' as stg_firebase_option;

import 'feature/app.dart';


const flavor = String.fromEnvironment('FLAVOR');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  // Flavorに応じたOptionsを準備する
  final firebaseOptions = flavor == 'prod'
      ? prod_firebase_option.DefaultFirebaseOptions.currentPlatform
      : flavor == 'stg'
          ? stg_firebase_option.DefaultFirebaseOptions.currentPlatform
          : dev_firebase_option.DefaultFirebaseOptions.currentPlatform;

  // Firebaseの初期化
  await Firebase.initializeApp(options: firebaseOptions);

  runApp(ProviderScope(child: App()));

}
