import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/provider_di.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/usecase/member_detail/get_member_detail_from_file.dart';
import '../../state/auth/member_detail_file.dart';

final memberDetailListProvider =
    StateNotifierProvider<MemberDetailListNotifier, MemberDetailFile>((ref) =>
        MemberDetailListNotifier(MemberDetailFile.noData(),
            getMemberDetailFromFile:
                ref.watch(getMemberDetailFromFileProvider)));

class MemberDetailListNotifier extends StateNotifier<MemberDetailFile> {
  MemberDetailListNotifier(super.state,
      {required this.getMemberDetailFromFile});

  final GetMemberDetailFromFile getMemberDetailFromFile;

  void reset() => state = MemberDetailFile.noData();

  Future<MemberDetailFile> pickFile() async {
    final result = await getMemberDetailFromFile(NoParams());
    state = result.fold((l) => throw Exception(l),
        (file) => MemberDetailFile(fileName: file.fileName, data: file.data));
    return state;
  }

  Future<void> addToDatabase() async {
    state = MemberDetailFile.noData();
  }
}
