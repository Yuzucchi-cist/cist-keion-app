import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/utils/firebase_setting.dart';
import 'feature/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Flavorに応じたOptionsを準備する
  final firebaseOptions = flavor.firebaseOptions;

  // Firebaseの初期化
  await Firebase.initializeApp(options: firebaseOptions);

  runApp(ProviderScope(child: App()));
}
