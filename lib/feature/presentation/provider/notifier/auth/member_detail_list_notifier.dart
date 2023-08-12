import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final memberDetailListProvider =
    StateNotifierProvider<MemberDetailListNotifier, String>(
        (ref) => MemberDetailListNotifier(''));

class MemberDetailListNotifier extends StateNotifier<String> {
  MemberDetailListNotifier(super.state);

  Future<void> pickFile() async {
    state = '${Random.secure().nextInt(10)}.xlsx';
  }

  Future<void> addToDatabase() async {
    state = '';
  }
}
