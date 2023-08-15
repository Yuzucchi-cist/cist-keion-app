import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/error/failure/failure.dart';
import '../../../../../core/provider_di.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/entity/member_detail/member_detail.dart';
import '../../../../domain/usecase/member_detail/add_member_detail_to_database.dart';
import '../../../../domain/usecase/member_detail/get_member_detail_from_file.dart';
import '../../state/auth/member_detail_file.dart';

final memberDetailListProvider =
    StateNotifierProvider<MemberDetailListNotifier, MemberDetailFile>((ref) =>
        MemberDetailListNotifier(
          MemberDetailFile.noData(),
          getMemberDetailFromFile: ref.watch(getMemberDetailFromFileProvider),
          addMemberDetailToDatabase: ref.watch(addMemberToDatabaseProvider),
        ));

class MemberDetailListNotifier extends StateNotifier<MemberDetailFile> {
  MemberDetailListNotifier(super.state,
      {required this.getMemberDetailFromFile,
      required this.addMemberDetailToDatabase});

  final GetMemberDetailFromFile getMemberDetailFromFile;
  final AddMemberDetailToDatabase addMemberDetailToDatabase;

  void reset() => state = MemberDetailFile.noData();

  Future<Either<Failure, MemberDetailFile>> pickFile() async {
    final result = (await getMemberDetailFromFile(NoParams())).bind((file) {
      state = MemberDetailFile(fileName: file.fileName, data: file.data);
      return Right(state);
    });
    return result;
  }

  Future<Either<Failure, List<MemberDetail>>> addToDatabase() async {
    final result = await addMemberDetailToDatabase(state.data);
    return result.bind((memberDetailList) {
      state = MemberDetailFile.noData();
      return Right(memberDetailList);
    });
  }
}
